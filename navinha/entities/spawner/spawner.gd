extends Sprite2D
class_name Spawner

@export var load_enemy : PackedScene
@onready var timer : Timer = %SpawnTime

@onready var pursuer : PackedScene
@onready var shooter : PackedScene

var enemy_pool : Array[PackedScene] = []

func _ready() -> void:
	pursuer = load("res://entities/enemies/pursuer/pursuer.tscn")
	shooter = load("res://entities/enemies/shooter/shooter.tscn")
	enemy_pool = [pursuer, shooter]

func spawn():
	timer.start()
	await timer.timeout
	var enemy : Node2D
	if load_enemy == null:
		var random_index = randi() % enemy_pool.size()
		enemy = enemy_pool[random_index].instantiate()
	else:
		enemy = load_enemy.instantiate()
	enemy.global_position = global_position
	add_sibling(enemy)
	queue_free()
