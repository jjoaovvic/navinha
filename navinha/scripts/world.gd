extends Node2D

func _ready() -> void:
	%GameOver.process_mode = Node.PROCESS_MODE_ALWAYS
	%Upgrade.process_mode = Node.PROCESS_MODE_ALWAYS

func _process(_delta: float) -> void:
	if Input.is_action_pressed("restart"):
		get_tree().reload_current_scene()

func spawn_enemy():
	var pursuer = preload("res://entities/enemies/pursuer/pursuer.tscn").instantiate()
	%Spawner.progress_ratio = randf()
	pursuer.global_position = %Spawner.global_position
	add_child(pursuer)

func set_upgrade():
	%UpgradeButton.set_upgrade()
	%UpgradeButton2.set_upgrade()
	%UpgradeButton3.set_upgrade()

func _on_pursuer_timer_timeout() -> void:
	spawn_enemy()

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
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
