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
var bullet_damage: Stat
var bullet_speed: Stat
var bullet_range: Stat
var critical_chance: Stat
var critical_damage: Stat
var fire_damage: Stat
var fire_chance: Stat


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
	stats.bullet_damage = Stat.new(base.bullet_damage)
	stats.bullet_speed = Stat.new(base.bullet_speed)
	stats.bullet_range = Stat.new(base.bullet_range)
	stats.critical_chance = Stat.new(base.critical_chance)
	stats.critical_damage = Stat.new(base.critical_damage)
	stats.fire_damage = Stat.new(base.fire_damage)
	stats.fire_chance = Stat.new(base.fire_chance)
	return stats


func shot_interval() -> float:
	return 1.0 / maxf(fire_rate.value, 0.01)
