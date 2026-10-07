extends Node2D
class_name WaveManager

@export var wave_quantity:int
@export var infinite_waves: bool = false
@export var initial_wave_difficulty:int = 1
var wave_difficulty:int = 0
var enemy_number:int = 3
var wave_in_progress : bool = false
var current_wave_number = 1


func _ready() -> void:
	if infinite_waves:
		wave_creator(3, 1)
		wave_call(current_wave_number)
	if !infinite_waves:
		for wave in wave_quantity:
			wave_creator(3, wave + 1)
		wave_call(current_wave_number)

func _process(_delta: float) -> void:
	wave_check()

func wave_check() -> void:
	if not wave_in_progress and !infinite_waves:
		return
	var wave = %Game.get_node_or_null("Wave " + str(current_wave_number))
	if wave == null:
		return
	if wave.get_children().is_empty():
		wave_in_progress = false
		current_wave_number += 1
		if not wave_in_progress and infinite_waves:
			wave_creator(3, current_wave_number)
		wave_call(current_wave_number)

func wave_call(wave):
	wave_in_progress = true
	var current_wave = %Game.get_node_or_null("Wave " + str(wave))
	if current_wave == null:
		print("Ganhou")
		return
	current_wave.visible = true
	var spawners = current_wave.get_children()
	for spawner in spawners:
		(spawner as Spawner).spawn()

func wave_creator(enemy_number:int, wave:int) -> void:
	var wave_group: Node2D = Node2D.new()
	var screen_size = get_viewport_rect().size
	wave_group.name = "Wave " + str(wave)
	wave_group.visible = false
	%Game.add_child(wave_group)
	for i in enemy_number:
		var spawner: Node2D = (load("res://entities/spawner/spawner.tscn") as PackedScene).instantiate()
		var random_x = randf_range(0, screen_size.x)
		var random_y = randf_range(0, screen_size.y)
		spawner.global_position = Vector2(random_x, random_y)
		wave_group.add_child(spawner)
