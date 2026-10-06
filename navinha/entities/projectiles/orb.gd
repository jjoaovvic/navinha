extends Area2D

var damage:float= 1.0

func _on_body_entered(body: Node2D) -> void:
	var health := HealthComponent.of(body)
	if health != null:
		health.take_damage(damage)
