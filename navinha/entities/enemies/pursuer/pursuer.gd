extends CharacterBody2D

@export var xp_value:int = 0
@export var HealthComponent : HealthComponent
@export var stats_component: StatsComponent
@onready var player : CharacterBody2D = get_node("/root/Test/Player")
@onready var stats: ShipStats = stats_component.stats
var drop_rate: float


func _physics_process(_delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * stats.speed.value
	move_and_slide()


func _on_health_component_health_depleted() -> void:
	player.xp_gain(xp_value)
	drop_rate = randf()
	if drop_rate > 0.9:
		call_deferred("spawn_life_pill")
	queue_free()

func spawn_life_pill() -> void:
	var pill = preload("res://entities/pickups/life_pill/life_pill.tscn").instantiate()
	pill.global_position = global_position
	get_tree().root.add_child(pill)
