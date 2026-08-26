extends Node2D
class_name HealthComponent

signal health_changed(current: float, maximum: float)
signal health_depleted

@export var stats: ShipStats

var _stats: ShipStats = ShipStats.new()

var max_health: float:
	get:
		return _stats.max_health.value

var current_health: float = 0.0:
	set(value):
		current_health = clampf(value, 0.0, max_health)
		health_changed.emit(current_health, max_health)
		if current_health <= 0.0:
			health_depleted.emit()


func _ready() -> void:
	# Resource exportado é compartilhado entre as instâncias da cena: sem a
	# cópia, ferir um inimigo feriria todos.
	if stats != null:
		_stats = stats.duplicate(true)
	current_health = max_health


func take_damage(amount: float) -> void:
	current_health -= amount


func life_gain(amount: float) -> void:
	current_health += amount
