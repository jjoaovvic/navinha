extends Area2D

@export var damage:float= 3.0

func _on_body_entered(body: Node2D) -> void:
	explosion()
	queue_free()
	
func explosion() -> void:
	var enemies = $ExplosionArea.get_overlapping_bodies()
	for enemy in enemies:
		if enemy.has_node("HealthComponent"):
			enemy.get_node("HealthComponent").take_damage(damage)
