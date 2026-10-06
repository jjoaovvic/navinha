extends ProjectileTrait
class_name ExplosionTrait

var radius: float
var damage_ratio: float
var delay: float


func _init(p_radius: float, p_damage_ratio: float = 1.0, p_delay: float = 0.0) -> void:
	radius = p_radius
	damage_ratio = p_damage_ratio
	delay = p_delay


func on_hit(bullet: Bullet, _body: Node2D) -> bool:
	_trigger(bullet)
	return true


func on_expire(bullet: Bullet) -> void:
	_trigger(bullet)


func _trigger(bullet: Bullet) -> void:
	var world := bullet.get_world_2d()
	var position := bullet.global_position
	var damage := bullet.damage * damage_ratio
	var mask := bullet.collision_mask
	if delay <= 0.0:
		_explode(world, position, damage, mask)
		return
	bullet.get_tree().create_timer(delay).timeout.connect(
		func() -> void: _explode(world, position, damage, mask)
	)


func _explode(world: World2D, position: Vector2, damage: float, mask: int) -> void:
	var shape := CircleShape2D.new()
	shape.radius = radius
	var query := PhysicsShapeQueryParameters2D.new()
	query.shape = shape
	query.transform = Transform2D(0.0, position)
	query.collision_mask = mask
	query.collide_with_bodies = true
	query.collide_with_areas = false
	for result in world.direct_space_state.intersect_shape(query):
		var body := result["collider"] as Node
		var health := HealthComponent.of(body) if body != null else null
		if health != null:
			health.take_damage(damage)
