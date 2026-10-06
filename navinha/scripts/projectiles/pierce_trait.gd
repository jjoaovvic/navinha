extends ProjectileTrait
class_name PierceTrait

var remaining: int


func _init(count: int) -> void:
	remaining = count


func on_hit(_bullet: Bullet, _body: Node2D) -> bool:
	if remaining <= 0:
		return true
	remaining -= 1
	return false
