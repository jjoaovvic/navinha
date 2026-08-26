extends Node
class_name StatsComponent

@export var profile: ShipProfile
@export var health_component: HealthComponent

var stats: ShipStats


func _enter_tree() -> void:
	stats = ShipStats.from_profile(profile)
	if health_component != null:
		health_component.health = stats.health
