extends RefCounted
class_name Upgrade

var title: String
var stat: ShipStat.Id
var kind: StatModifier.Kind
var amount: float


func _init(p_title: String, p_stat: ShipStat.Id, p_kind: StatModifier.Kind, p_amount: float) -> void:
	title = p_title
	stat = p_stat
	kind = p_kind
	amount = p_amount


func apply(stats: ShipStats) -> void:
	stats.of(stat).add_modifier(StatModifier.new(kind, amount, &"upgrade"))
