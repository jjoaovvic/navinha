extends CharacterBody2D

const SPEED = 500.0
const BULLET_TIME = 0.2
const ROTATION_SPEED = 10.0
const DEADZONE = 0.2
var can_shoot = 1
var target_angle: float

func _ready() -> void:
	%Bullet_Timer.wait_time = BULLET_TIME

func get_input():
	var direction := Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED
	
func shoot():
	const BULLET = preload("res://prefabs/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_transform = %Gun.global_transform
	new_bullet.global_rotation = %Gun.global_rotation
	add_child(new_bullet)

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
	#ATIVAR PARA CONTROLAR O TIRO PELO MOUSE
	#look_at(get_global_mouse_position())
	if Input.is_action_pressed("shoot") and can_shoot == 1:
		shoot()
		can_shoot = 0
		%Bullet_Timer.start()
	var drotation := Input.get_vector("cleft", "cright", "cup", "cdown")
	if drotation.length() >= DEADZONE: 
		target_angle = drotation.angle()
	if rotation != target_angle:
		var rotation_larp_weight: float = 1.0 - exp(-ROTATION_SPEED * delta)
		rotation = lerp_angle(rotation, target_angle, rotation_larp_weight)

func _on_bullet_time_timeout() -> void:
	can_shoot = 1
