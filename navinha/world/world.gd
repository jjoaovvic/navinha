extends Node2D

@export var wave_quantity:int
var wave_in_progress : bool = false
var current_wave_number = 1

func _ready() -> void:
	%GameOver.process_mode = Node.PROCESS_MODE_ALWAYS
	%Upgrade.process_mode = Node.PROCESS_MODE_ALWAYS
	for wave in wave_quantity:
		wave_creator(3, wave + 1)
	wave_call(current_wave_number)

func _process(_delta: float) -> void:
	if Input.is_action_pressed("restart"):
		get_tree().reload_current_scene()
	if not wave_in_progress:
		return
	var wave = get_node_or_null("Wave " + str(current_wave_number))
	if wave == null:
		return
	if wave.get_children().is_empty():
		wave_in_progress = false
		current_wave_number += 1
		wave_call(current_wave_number)

#func spawn_enemy():
	#var pursuer = preload("res://entities/enemies/pursuer/pursuer.tscn").instantiate()
	#%Spawner.progress_ratio = randf()
	#pursuer.global_position = %Spawner.global_position
	#add_child(pursuer)

func wave_call(wave):
	wave_in_progress = true
	var current_wave = get_node_or_null("Wave " + str(wave))
	if current_wave == null:
		print("Ganhou")
		return
	current_wave.visible = true
	var spawners = current_wave.get_children()
	for spawner in spawners:
		spawner.spawn()

func set_upgrade():
	%UpgradeButton.set_upgrade()
	%UpgradeButton2.set_upgrade()
	%UpgradeButton3.set_upgrade()

#func _on_pursuer_timer_timeout() -> void:
	#spawn_enemy()

func _on_player_died() -> void:
	%GameOver.visible = true
	get_tree().paused = true

func _on_upgrade_button_pressed(button_path:NodePath) -> void:
	var button = get_node(button_path)
	button.call_upgrade()
	get_tree().paused = false
	%Upgrade.visible = false

func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://ui/main_menu/main_menu.tscn")

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func wave_creator(enemy_number:int, wave:int) -> void:
	var wave_group: Node2D = Node2D.new()
	var screen_size = get_viewport_rect().size
	wave_group.name = "Wave " + str(wave)
	wave_group.visible = false
	add_child(wave_group)
	for i in enemy_number:
		var spawner = load("res://entities/spawner/spawner.tscn").instantiate()
		var random_x = randf_range(0, screen_size.x)
		var random_y = randf_range(0, screen_size.y)
		spawner.global_position = Vector2(random_x, random_y)
		wave_group.add_child(spawner)
