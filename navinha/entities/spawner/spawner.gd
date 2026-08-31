extends Sprite2D

@export var load_enemy : PackedScene
var pursuer = preload("res://entities/enemies/pursuer/pursuer.tscn")
var shooter = preload("res://entities/enemies/shooter/shooter.tscn")
@onready var timer = %SpawnTime


func spawn():
	timer.start()
	await timer.timeout
	var enemy : Node2D
	if load_enemy == null:
		var random_enemy = randi() % 2
		var enemies = [pursuer, shooter]
		enemy = enemies[random_enemy].instantiate()
	else:
		enemy = load_enemy.instantiate()
	enemy.global_position = global_position
	add_sibling(enemy)
	queue_free()
