extends Sprite2D

@export var load_enemy : PackedScene

func spawn():
	var enemy = load_enemy.instantiate()
	enemy.global_position = global_position
	add_sibling(enemy)
	queue_free()
