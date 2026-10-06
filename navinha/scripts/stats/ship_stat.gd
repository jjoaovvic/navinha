@tool
class_name ShipStat

enum Id {
	MAX_HEALTH,
	HEALTH_REGEN,
	SPEED,
	ACCELERATION,
	FRICTION,
	FIRE_RATE,
	MAX_BOOST,
	BOOST_DRAIN,
	BOOST_RECOVERY,
	BOOST_MULTIPLIER,
	BULLET_DAMAGE,
	BULLET_SPEED,
	BULLET_RANGE,
	CRITICAL_CHANCE,
	CRITICAL_DAMAGE,
	FIRE_DAMAGE,
	FIRE_CHANCE,
}


static func default_of(id: Id) -> float:
	match id:
		Id.MAX_HEALTH, Id.BOOST_MULTIPLIER, Id.BULLET_DAMAGE, Id.FIRE_DAMAGE, Id.FIRE_CHANCE:
			return 1.0
		Id.BULLET_SPEED:
			return 1500.0
		Id.BULLET_RANGE:
			return 800.0
		Id.CRITICAL_CHANCE:
			return 0.01
		Id.CRITICAL_DAMAGE:
			return 1.5
		_:
			return 0.0


static func name_of(id: Id) -> StringName:
	return StringName(String(Id.find_key(id)).to_lower())
