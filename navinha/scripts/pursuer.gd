extends CharacterBody2D

@export var HealthComponent : HealthComponent
@onready var player : CharacterBody2D = get_node("/root/Test/Player")
var drop_rate: float


func _physics_process(_delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300.0
	move_and_slide()


func _on_health_component_health_depleted() -> void:
	drop_rate = randf()
	if drop_rate > 0.5:
		var pill = preload("res://prefabs/life_pill.tscn").instantiate()
		pill.global_position = global_position
		add_sibling(pill)
