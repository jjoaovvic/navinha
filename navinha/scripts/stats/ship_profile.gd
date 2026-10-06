@tool
extends StatSheet
class_name ShipProfile

static var _cached_names := PackedStringArray()


func _names() -> PackedStringArray:
	if _cached_names.is_empty():
		for id: int in ShipStat.Id.values():
			_cached_names.append(ShipStat.name_of(id as ShipStat.Id))
	return _cached_names


func _default_at(index: int) -> float:
	return ShipStat.default_of(index as ShipStat.Id)


func base(id: ShipStat.Id) -> float:
	return value_at(id)
