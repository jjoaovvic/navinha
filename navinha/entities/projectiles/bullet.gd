extends Area2D

@export var damage:float = 1.0
@export var speed := 1000
var range := 1200
var fire_damage:float = 0.0
var travelled_distance = 0
var start_position = Vector2.ZERO

func _ready() -> void:
	start_position = position

func _physics_process(delta):
	position += Vector2.RIGHT.rotated(rotation) * speed * delta
	#travelled_distance += speed * delta
	if position.distance_to(start_position) > range:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	queue_free()
	var health := HealthComponent.of(body)
	if health != null:
		health.take_damage(damage)
		health.fire_damage = fire_damage
