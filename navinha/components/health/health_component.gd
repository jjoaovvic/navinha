extends Node2D
class_name HealthComponent

signal health_changed(current: float, maximum: float)
signal health_depleted

var health: Health


func _ready() -> void:
	assert(health != null, "HealthComponent nao recebeu um Health")
	health.changed.connect(_on_changed)
	health.depleted.connect(_on_depleted)
	health_changed.emit(health.current, health.maximum.value)


func _process(delta: float) -> void:
	health.regenerate(delta)


func take_damage(amount: float) -> void:
	health.take_damage(amount)


func life_gain(amount: float) -> void:
	health.heal(amount)


func _on_changed(current: float, maximum: float) -> void:
	health_changed.emit(current, maximum)


func _on_depleted() -> void:
	health_depleted.emit()
