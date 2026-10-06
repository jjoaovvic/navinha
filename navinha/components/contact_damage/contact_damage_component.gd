extends Area2D

@export var damage := 1

func _on_body_entered(body: Node2D) -> void:
	get_parent().queue_free()
	var health := HealthComponent.of(body)
	if health != null:
		health.take_damage(damage)
