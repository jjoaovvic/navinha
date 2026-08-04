extends Node2D
class_name HealthComponent

@export var MAX_HEALTH := 1.0
@export var player_health : ProgressBar
var health

func _ready() -> void:
	health = MAX_HEALTH
	if get_parent().name == "Player":
		player_health.value = (health / MAX_HEALTH) * 100
		print(player_health.value)

func take_damage():
	health -= 1
	print(health)
	if get_parent().name == "Player":
		player_health.value = (health / MAX_HEALTH) * 100
		print(player_health.value)
	if health == 0:
		if get_parent().name == "Player":
			pass;
		else:
			get_parent().queue_free()
