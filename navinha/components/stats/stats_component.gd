extends Node
class_name StatsComponent

@export var profile: ShipProfile

var stats: ShipStats


func _enter_tree() -> void:
	stats = ShipStats.from_profile(profile)
