extends CharacterBody2D

@export var HealthComponent : HealthComponent
@onready var player = %Player


func _physics_process(_delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300.0
	move_and_slide()
