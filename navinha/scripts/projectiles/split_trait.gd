extends ProjectileTrait
class_name SplitTrait

var count: int
var spread_degrees: float
var remaining: int
var spawn_offset: float = 24.0


func _init(p_count: int, p_spread_degrees: float = 30.0, p_remaining: int = 1) -> void:
	count = p_count
	spread_degrees = p_spread_degrees
	remaining = p_remaining


func on_hit(bullet: Bullet, _body: Node2D) -> bool:
	if remaining <= 0 or bullet.scene_file_path == "":
		return true
	var scene := load(bullet.scene_file_path) as PackedScene
	var spread_rad := deg_to_rad(spread_degrees)
	var mid := (count - 1) / 2.0
	for i in count:
		var fragment := scene.instantiate() as Bullet
		var fragment_rotation := bullet.global_rotation + (i - mid) * spread_rad
		fragment.damage = bullet.damage
		fragment.speed = bullet.speed
		fragment.range = bullet.range
		fragment.fire_damage = bullet.fire_damage
		fragment.global_rotation = fragment_rotation
		fragment.global_position = (
			bullet.global_position + Vector2.RIGHT.rotated(fragment_rotation) * spawn_offset
		)
		if remaining > 1:
			var fragment_traits: Array[ProjectileTrait] = [SplitTrait.new(count, spread_degrees, remaining - 1)]
			fragment.traits = fragment_traits
		bullet.get_parent().add_child.call_deferred(fragment)
	return true
