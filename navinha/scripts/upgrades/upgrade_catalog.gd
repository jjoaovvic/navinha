extends RefCounted
class_name UpgradeCatalog

static func all() -> Array[Upgrade]:
	return [
		Upgrade.new("Max Health +10", ShipStat.Id.MAX_HEALTH, StatModifier.Kind.FLAT, 10.0),
		Upgrade.new("Health Regen +0.5/s", ShipStat.Id.HEALTH_REGEN, StatModifier.Kind.FLAT, 0.5),
		Upgrade.new("Max Boost +10", ShipStat.Id.MAX_BOOST, StatModifier.Kind.FLAT, 10.0),
		Upgrade.new("Fire Rate +10%", ShipStat.Id.FIRE_RATE, StatModifier.Kind.ADDITIVE, 0.1),
		Upgrade.new("Bullet Damage +25%", ShipStat.Id.BULLET_DAMAGE, StatModifier.Kind.ADDITIVE, 0.25),
		Upgrade.new("Bullet Range +20%", ShipStat.Id.BULLET_RANGE, StatModifier.Kind.ADDITIVE, 0.2),
		Upgrade.new("Speed +10%", ShipStat.Id.SPEED, StatModifier.Kind.ADDITIVE, 0.1),
	]


static func pick_random(count: int) -> Array[Upgrade]:
	var pool := all()
	pool.shuffle()
	return pool.slice(0, mini(count, pool.size()))
