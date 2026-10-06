@tool
extends Resource
class_name StatSheet

var _values := PackedFloat64Array()


func _init() -> void:
	_values.resize(_names().size())
	for i in _values.size():
		_values[i] = _default_at(i)


func _names() -> PackedStringArray:
	return PackedStringArray()


func _default_at(_index: int) -> float:
	return 0.0


func value_at(index: int) -> float:
	return _values[index]


func build_stats() -> Array[Stat]:
	var stats: Array[Stat] = []
	for value in _values:
		stats.append(Stat.new(value))
	return stats


func _get_property_list() -> Array[Dictionary]:
	var properties: Array[Dictionary] = []
	var names := _names()
	for i in names.size():
		var overridden := not is_equal_approx(_values[i], _default_at(i))
		properties.append({
			"name": names[i],
			"type": TYPE_FLOAT,
			"usage": PROPERTY_USAGE_DEFAULT if overridden else PROPERTY_USAGE_EDITOR,
		})
	return properties


func _get(property: StringName) -> Variant:
	var index := _names().find(property)
	return null if index < 0 else _values[index]


func _set(property: StringName, value: Variant) -> bool:
	var index := _names().find(property)
	if index < 0:
		return false
	_values[index] = float(value)
	return true


func _property_can_revert(property: StringName) -> bool:
	return _names().has(property)


func _property_get_revert(property: StringName) -> Variant:
	var index := _names().find(property)
	return null if index < 0 else _default_at(index)
