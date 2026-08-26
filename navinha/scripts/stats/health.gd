extends RefCounted
class_name Health

signal changed(current: float, maximum: float)
signal depleted

var maximum: Stat
var regen: Stat

var current: float:
	set(value):
		current = clampf(value, 0.0, maximum.value)
		changed.emit(current, maximum.value)
		if current <= 0.0:
			depleted.emit()


func _init(p_maximum: Stat, p_regen: Stat) -> void:
	maximum = p_maximum
	regen = p_regen
	current = maximum.value
	maximum.changed.connect(_on_maximum_changed)


func take_damage(amount: float) -> void:
	current -= amount


func heal(amount: float) -> void:
	current += amount


## Quanto regenerar num intervalo. Quem chama decide quando.
func regenerate(delta: float) -> void:
	if current > 0.0 and regen.value > 0.0:
		current += regen.value * delta


func _on_maximum_changed() -> void:
	current = minf(current, maximum.value)


func is_depleted() -> bool:
	return current <= 0.0


func is_full() -> bool:
	return is_equal_approx(current, maximum.value)


func ratio() -> float:
	var top := maximum.value
	return current / top if top > 0.0 else 0.0
