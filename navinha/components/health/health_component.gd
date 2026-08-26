extends Node2D
class_name HealthComponent

signal health_changed(current: float, maximum: float)
signal health_depleted

var maximum: Stat

var max_health: float:
	get:
		return maximum.value

var current_health: float = 0.0:
	set(value):
		current_health = clampf(value, 0.0, max_health)
		health_changed.emit(current_health, max_health)
		if current_health <= 0.0:
			health_depleted.emit()


func _ready() -> void:
	assert(maximum != null, "HealthComponent nao recebeu o Stat de vida maxima")
	current_health = max_health


func take_damage(amount: float) -> void:
	current_health -= amount


func life_gain(amount: float) -> void:
	current_health += amount
