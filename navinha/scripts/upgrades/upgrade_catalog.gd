extends RefCounted
class_name UpgradeCatalog

static func all() -> Array[Upgrade]:
	return [
		Upgrade.new("Max Health +10", &"health.maximum", StatModifier.Kind.FLAT, 10.0),
		Upgrade.new("Health Regen +0.5/s", &"health.regen", StatModifier.Kind.FLAT, 0.5),
		Upgrade.new("Max Boost +10", &"max_boost", StatModifier.Kind.FLAT, 10.0),
		Upgrade.new("Fire Rate +10%", &"fire_rate", StatModifier.Kind.ADDITIVE, 0.1),
		Upgrade.new("Bullet Damage +25%", &"bullet_damage", StatModifier.Kind.ADDITIVE, 0.25),
		Upgrade.new("Bullet Range +20%", &"bullet_range", StatModifier.Kind.ADDITIVE, 0.2),
		Upgrade.new("Speed +10%", &"speed", StatModifier.Kind.ADDITIVE, 0.1),
	]


static func pick_random(count: int) -> Array[Upgrade]:
	var pool := all()
	pool.shuffle()
	return pool.slice(0, mini(count, pool.size()))
