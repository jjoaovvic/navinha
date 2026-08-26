extends RefCounted
class_name ShipStats

var health: Health
var speed: Stat
var acceleration: Stat
var friction: Stat
var fire_rate: Stat
var max_boost: Stat
var boost_drain: Stat
var boost_recovery: Stat
var boost_multiplier: Stat


static func from_profile(profile: ShipProfile) -> ShipStats:
	var base := profile if profile != null else ShipProfile.new()
	var stats := ShipStats.new()
	stats.health = Health.new(Stat.new(base.max_health), Stat.new(base.health_regen))
	stats.speed = Stat.new(base.speed)
	stats.acceleration = Stat.new(base.acceleration)
	stats.friction = Stat.new(base.friction)
	stats.fire_rate = Stat.new(base.fire_rate)
	stats.max_boost = Stat.new(base.max_boost)
	stats.boost_drain = Stat.new(base.boost_drain)
	stats.boost_recovery = Stat.new(base.boost_recovery)
	stats.boost_multiplier = Stat.new(base.boost_multiplier)
	return stats


func shot_interval() -> float:
	return 1.0 / maxf(fire_rate.value, 0.01)
