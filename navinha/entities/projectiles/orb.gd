extends Area2D

var damage:float= 1.0

func _on_body_entered(body: Node2D) -> void:
	if body.has_node("HealthComponent"):
		body.get_node("HealthComponent").take_damage(damage)
