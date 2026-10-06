extends Area2D

@export var life: int
var collected = false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and not collected:
		collected = true
		HealthComponent.of(body).life_gain(life)
		call_deferred("queue_free")
