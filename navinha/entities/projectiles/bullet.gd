extends Area2D
class_name Bullet

@export var damage: float = 1.0
@export var speed: float = 1000.0
var range: float = 1200.0
var fire_damage: float = 0.0
var start_position := Vector2.ZERO

var traits: Array[ProjectileTrait] = []


func _ready() -> void:
	start_position = position
	for t in traits:
		t.on_spawn(self)


func _physics_process(delta: float) -> void:
	position += Vector2.RIGHT.rotated(rotation) * speed * delta
	if position.distance_to(start_position) > range:
		_expire()


func _expire() -> void:
	for t in traits:
		t.on_expire(self)
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	var health := HealthComponent.of(body)
	if health != null:
		health.take_damage(damage)
		health.fire_damage = fire_damage
	var destroy := true
	for t in traits:
		if not t.on_hit(self, body):
			destroy = false
	if destroy:
		queue_free()
