extends RefCounted
class_name ModifierBucket

## Um lado do acumulado de um Stat: só buffs, ou só debuffs.

var flat := 0.0
var additive := 0.0
var multiplier := 1.0

var modifiers: Array[StatModifier] = []


func add(modifier: StatModifier) -> void:
	modifiers.append(modifier)
	_accumulate(modifier)


func remove_from(source: StringName) -> int:
	var kept: Array[StatModifier] = []
	for modifier in modifiers:
		if modifier.source != source:
			kept.append(modifier)
	var removed := modifiers.size() - kept.size()
	if removed > 0:
		modifiers = kept
		_rebuild()
	return removed


func _accumulate(modifier: StatModifier) -> void:
	match modifier.kind:
		StatModifier.Kind.FLAT:
			flat += modifier.amount
		StatModifier.Kind.ADDITIVE:
			additive += modifier.amount
		StatModifier.Kind.MULTIPLICATIVE:
			multiplier *= maxf(0.0, 1.0 + modifier.amount)


func _rebuild() -> void:
	flat = 0.0
	additive = 0.0
	multiplier = 1.0
	for modifier in modifiers:
		_accumulate(modifier)
