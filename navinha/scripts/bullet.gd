extends Area2D

var travelled_distance = 0

func _physics_process(delta):
	const SPEED = 1000
	const RANGE = 1200

	position += Vector2.RIGHT.rotated(rotation) * SPEED * delta
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	queue_free()
	if body.has_node("HealthComponent"):
		body.get_node("HealthComponent").take_damage()
