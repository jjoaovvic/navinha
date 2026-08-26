extends CharacterBody2D

@export var stats_component: StatsComponent

@onready var boost_bar = %Player_Boost
@onready var boost_timer = %Boost_Timer
@onready var stats: ShipStats = stats_component.stats

const ROTATION_SPEED = 10.0
const DEADZONE = 0.2

var xp:int
var can_boost_recovery = true
var boost_effect = 1
var can_shoot = 1
var target_angle: float
signal died

func _ready() -> void:
	%Bullet_Timer.wait_time = stats.shot_interval()
	boost_bar.max_value = stats.max_boost.value
	boost_bar.value = boost_bar.max_value
	stats.fire_rate.changed.connect(_on_fire_rate_changed)
	stats.max_boost.changed.connect(_on_max_boost_changed)

func get_input() -> Vector2:
	var direction := Input.get_vector("left", "right", "up", "down")
	return direction

func shoot():
	const BULLET = preload("res://entities/projectiles/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_transform = %Gun.global_transform
	new_bullet.global_rotation = %Gun.global_rotation
	add_child(new_bullet)

func process_movement(delta: float, move_direction: Vector2) ->void:
	var target_velocity:Vector2 = move_direction * stats.speed.value * boost_effect
	velocity = (velocity.lerp(target_velocity, delta * stats.acceleration.value) 
		if target_velocity else
		velocity.lerp(target_velocity, delta * stats.friction.value))

func _physics_process(delta: float) -> void:
	var move_direction: Vector2
	move_direction = get_input()
	move_and_slide()
	process_movement(delta, move_direction)
	
	#ATIVAR PARA CONTROLAR O TIRO PELO MOUSE
	look_at(get_global_mouse_position())
	
	
	#ATIVAR PARA CONTROLAR O TIRO PELO CONTROLE
	#var drotation := Input.get_vector("cleft", "cright", "cup", "cdown")
	#if drotation.length() >= DEADZONE: 
		#target_angle = drotation.angle()
	#if rotation != target_angle:
		#var rotation_larp_weight: float = 1.0 - exp(-ROTATION_SPEED * delta)
		#rotation = lerp_angle(rotation, target_angle, rotation_larp_weight)
		
	if Input.is_action_pressed("shoot") and can_shoot == 1:
		shoot()
		can_shoot = 0
		%Bullet_Timer.start()
		
	if Input.is_action_pressed("boost"):
		boost_effect = stats.boost_multiplier.value
		boost_bar.value -= delta * stats.boost_drain.value
		can_boost_recovery = false
		boost_timer.start()
	else:
		boost_effect = 1
		if can_boost_recovery:
			boost_bar.value += delta * stats.boost_recovery.value

func _on_bullet_time_timeout() -> void:
	can_shoot = 1

func _on_health_component_health_depleted() -> void:
	died.emit()


func _on_health_component_health_changed(current: float, maximum: float) -> void:
	%Player_Health.max_value = maximum
	%Player_Health.value = current

func _on_fire_rate_changed() -> void:
	%Bullet_Timer.wait_time = stats.shot_interval()

func _on_max_boost_changed() -> void:
	boost_bar.max_value = stats.max_boost.value

func _on_boost_timer_timeout() -> void:
	can_boost_recovery = true

func xp_gain(gain) -> void:
	xp += gain
	if xp == 5:
		%Upgrade.visible = true
		var world = get_parent()
		world.set_upgrade()
		get_tree().paused = true
		xp = 0
	print(xp)
