extends RefCounted
class_name Upgrade

var title: String
var stat_name: StringName
var kind: StatModifier.Kind
var amount: float


func _init(p_title: String, p_stat_name: StringName, p_kind: StatModifier.Kind, p_amount: float) -> void:
	title = p_title
	stat_name = p_stat_name
	kind = p_kind
	amount = p_amount


func apply(stats: ShipStats) -> void:
	var stat := _resolve(stats)
	assert(stat != null, "Upgrade aponta para um stat inexistente: %s" % stat_name)
	stat.add_modifier(StatModifier.new(kind, amount, &"upgrade"))


func _resolve(stats: ShipStats) -> Stat:
	match stat_name:
		&"health.maximum":
			return stats.health.maximum
		&"health.regen":
			return stats.health.regen
		_:
			return stats.get(stat_name)
