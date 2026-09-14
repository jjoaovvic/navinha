extends Area2D

@export var damage:float = 1.0
@export var speed := 1000
@export var range := 1200
var travelled_distance = 0


func _physics_process(delta):
	position += Vector2.RIGHT.rotated(rotation) * speed * delta
	travelled_distance += speed * delta
	if travelled_distance > range:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	queue_free()
	if body.has_node("HealthComponent"):
		body.get_node("HealthComponent").take_damage(damage)
