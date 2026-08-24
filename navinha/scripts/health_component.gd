extends Node2D
class_name HealthComponent

@export var MAX_HEALTH := 1.0
@export var player_health : ProgressBar
signal health_depleted
var health

func _ready() -> void:
	health = MAX_HEALTH
	if get_parent().name == "Player":
		player_health.value = (health / MAX_HEALTH) * 100
		print(player_health.value)

func take_damage(damage):
	health -= damage
	if get_parent().name == "Player":
		player_health.value = (health / MAX_HEALTH) * 100
	if health == 0:
		health_depleted.emit()
		if get_parent().name != "Player":
			get_parent().queue_free()

func life_gain(damage):
	health += damage
