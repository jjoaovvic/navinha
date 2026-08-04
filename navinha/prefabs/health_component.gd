extends Node2D
class_name HealthComponent

@export var MAX_HEALTH := 1
var health

func _ready() -> void:
	health = MAX_HEALTH

func take_damage():
	health -= 1
	if health == 0:
		get_parent().queue_free()
