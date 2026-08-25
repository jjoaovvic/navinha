extends Area2D

@export var damage := 1

func _on_body_entered(body: Node2D) -> void:
	get_parent().queue_free()
	if body.has_node("HealthComponent"):
		body.get_node("HealthComponent").take_damage(damage)
