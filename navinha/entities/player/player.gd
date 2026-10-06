extends CharacterBody2D
class_name Player

@export var stats_component: StatsComponent

@onready var boost_bar: ProgressBar = %Player_Boost
@onready var boost_timer: Timer = %Boost_Timer
@onready var bullet_timer: Timer = %Bullet_Timer
@onready var stats: ShipStats = stats_component.stats


const ROTATION_SPEED = 10.0
const DEADZONE = 0.2

var xp:int
var can_boost_recovery = true
var boost_effect = 1
var can_shoot = 1
var target_angle: float
var bullet_qnt:int = 2
signal died

func _ready() -> void:
	bullet_timer.wait_time = stats.shot_interval()
	_on_boost_changed(stats.boost.current, stats.boost.maximum.value)
	stats.of(ShipStat.Id.FIRE_RATE).changed.connect(_on_fire_rate_changed)
	stats.boost.changed.connect(_on_boost_changed)

func get_input() -> Vector2:
	var direction := Input.get_vector("left", "right", "up", "down")
	return direction

func shoot():
	if bullet_qnt % 2 == 1:
		for bullet in range(bullet_qnt):
			create_bullet(bullet + 1)
	else:
		for bullet in range(bullet_qnt):
			create_bullet(bullet + 2)

func create_bullet(gun):
	const BULLET = preload("res://entities/projectiles/bullet.tscn")
	var new_bullet := BULLET.instantiate() as Bullet
	var gun_marker: Marker2D = get_node("Gun"+str(gun))
	new_bullet.global_transform = gun_marker.global_transform
	new_bullet.global_rotation = gun_marker.global_rotation
	if randf() <= stats.of(ShipStat.Id.CRITICAL_CHANCE).value:
		new_bullet.damage = stats.of(ShipStat.Id.BULLET_DAMAGE).value * stats.of(ShipStat.Id.CRITICAL_DAMAGE).value
		new_bullet.modulate = Color.YELLOW
	else:
		new_bullet.damage = stats.of(ShipStat.Id.BULLET_DAMAGE).value
	if randf() <= stats.of(ShipStat.Id.FIRE_CHANCE).value:
		new_bullet.fire_damage += stats.of(ShipStat.Id.FIRE_DAMAGE).value
		new_bullet.modulate = Color.RED
	new_bullet.speed = stats.of(ShipStat.Id.BULLET_SPEED).value
	new_bullet.range = stats.of(ShipStat.Id.BULLET_RANGE).value
	add_sibling(new_bullet)

func process_movement(delta: float, move_direction: Vector2) ->void:
	var target_velocity:Vector2 = move_direction * stats.of(ShipStat.Id.SPEED).value * boost_effect
	velocity = (velocity.lerp(target_velocity, delta * stats.of(ShipStat.Id.ACCELERATION).value) 
		if target_velocity else
		velocity.lerp(target_velocity, delta * stats.of(ShipStat.Id.FRICTION).value))

func _physics_process(delta: float) -> void:
	var move_direction: Vector2
	move_direction = get_input()
	move_and_slide()
	process_movement(delta, move_direction)
	
	var drotation := Input.get_vector("cleft", "cright", "cup", "cdown")
	if drotation.length() >= DEADZONE:
		target_angle = drotation.angle()
		var rotation_larp_weight: float = 1.0 - exp(-ROTATION_SPEED * delta)
		rotation = lerp_angle(rotation, target_angle, rotation_larp_weight)
	else:
		look_at(get_global_mouse_position())

	if Input.is_action_pressed("shoot") and can_shoot == 1:
		shoot()
		can_shoot = 0
		bullet_timer.start()
		
	if Input.is_action_pressed("boost"):
		boost_effect = stats.of(ShipStat.Id.BOOST_MULTIPLIER).value
		stats.boost.drain(delta * stats.of(ShipStat.Id.BOOST_DRAIN).value)
		can_boost_recovery = false
		boost_timer.start()
	else:
		boost_effect = 1
		if can_boost_recovery:
			stats.boost.restore(delta * stats.boost.regen.value)

func _on_bullet_time_timeout() -> void:
	can_shoot = 1

func _on_health_component_health_depleted() -> void:
	died.emit()


func _on_health_component_health_changed(current: float, maximum: float) -> void:
	var health_bar := %Player_Health as ProgressBar
	health_bar.max_value = maximum
	health_bar.value = current

func _on_fire_rate_changed() -> void:
	bullet_timer.wait_time = stats.shot_interval()

func _on_boost_changed(current: float, maximum: float) -> void:
	boost_bar.max_value = maximum
	boost_bar.value = current

func _on_boost_timer_timeout() -> void:
	can_boost_recovery = true

func xp_gain(gain) -> void:
	xp += gain
	if xp == 5:
		(%Upgrade as CanvasLayer).visible = true
		(%UpgradeButton as Button).grab_focus()
		var world := get_parent().get_parent() as World
		world.set_upgrade()
		get_tree().paused = true
		xp = 0
