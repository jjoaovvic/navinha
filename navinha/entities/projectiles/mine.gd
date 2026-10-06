extends Area2D

@export var damage:float= 3.0

func _on_body_entered(body: Node2D) -> void:
	explosion()
	queue_free()
	
func explosion() -> void:
	var enemies := ($ExplosionArea as Area2D).get_overlapping_bodies()
	for enemy in enemies:
		var health := HealthComponent.of(enemy)
		if health != null:
			health.take_damage(damage)
