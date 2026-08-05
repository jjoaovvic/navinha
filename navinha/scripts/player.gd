extends CharacterBody2D

#@export var HealthComponent : HealthComponent

const SPEED = 500.0
const BULLET_TIME = 0.2
const ROTATION_SPEED = 10.0
const DEADZONE = 0.2
const FRICTION = 2
const ACCELERATION = 5
var can_shoot = 1
var target_angle: float

func _ready() -> void:
	%Bullet_Timer.wait_time = BULLET_TIME

func get_input() -> Vector2:
	var direction := Input.get_vector("left", "right", "up", "down")
	return direction

func shoot():
	const BULLET = preload("res://prefabs/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_transform = %Gun.global_transform
	new_bullet.global_rotation = %Gun.global_rotation
	add_child(new_bullet)

func process_movement(delta: float, move_direction: Vector2) ->void:
	var target_velocity := move_direction * SPEED
	velocity = (velocity.lerp(target_velocity, delta * ACCELERATION) 
		if target_velocity else
		velocity.lerp(target_velocity, delta * FRICTION))

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

func _on_bullet_time_timeout() -> void:
	can_shoot = 1
