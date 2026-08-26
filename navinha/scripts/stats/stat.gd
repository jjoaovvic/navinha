extends Resource
class_name Stat

@export var base_value: float = 0.0:
	set(new_value):
		base_value = new_value
		_refresh()

## Pré-calculado: só muda quando o base ou os modificadores mudam.
var value: float:
	get:
		return _value

var buffs := ModifierBucket.new()
var debuffs := ModifierBucket.new()

var _value := 0.0


func _init(p_base_value := 0.0) -> void:
	base_value = p_base_value


func add_modifier(modifier: StatModifier) -> void:
	(debuffs if modifier.amount < 0.0 else buffs).add(modifier)
	_refresh()


func remove_modifiers_from(source: StringName) -> int:
	var removed := buffs.remove_from(source) + debuffs.remove_from(source)
	if removed > 0:
		_refresh()
	return removed


func _refresh() -> void:
	_value = (
		maxf(0.0, base_value + buffs.flat + debuffs.flat)
		* maxf(0.0, 1.0 + buffs.additive + debuffs.additive)
		* buffs.multiplier
		* debuffs.multiplier
	)
	emit_changed()
