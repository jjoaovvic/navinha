extends RefCounted
class_name ShipStats

var health: Pool
var _stats: Array[Stat] = []


static func from_profile(profile: ShipProfile) -> ShipStats:
	var base := profile if profile != null else ShipProfile.new()
	var stats := ShipStats.new()
	stats._stats = base.build_stats()
	stats.health = Pool.new(stats.of(ShipStat.Id.MAX_HEALTH), stats.of(ShipStat.Id.HEALTH_REGEN))
	return stats


func of(id: ShipStat.Id) -> Stat:
	return _stats[id]


func shot_interval() -> float:
	return 1.0 / maxf(of(ShipStat.Id.FIRE_RATE).value, 0.01)
