extends RefCounted
class_name ProjectileTrait

func on_spawn(_bullet: Bullet) -> void:
	pass


func on_hit(_bullet: Bullet, _body: Node2D) -> bool:
	return true


func on_expire(_bullet: Bullet) -> void:
	pass
