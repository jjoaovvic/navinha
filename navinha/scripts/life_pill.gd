extends Area2D

@export var life: int
var collected = false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and not collected:
		collected = true
		var health_component = body.get_node("HealthComponent")
		health_component.life_gain(life)
		queue_free()
