extends Node
class_name StatsComponent

@export var profile: ShipProfile
@export var health: HealthComponent

var stats: ShipStats


func _enter_tree() -> void:
	stats = ShipStats.from_profile(profile)
	if health != null:
		health.maximum = stats.max_health
