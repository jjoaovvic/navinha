extends CharacterBody2D

@export var HealthComponent : HealthComponent
@export var stats_component: StatsComponent
@onready var player = get_node("/root/Test/Player")
@onready var stats: ShipStats = stats_component.stats
var can_shoot = 0

func _ready() -> void:
	%Bullet_Timer_Enemy.wait_time = stats.shot_interval()
	%Bullet_Timer_Enemy.start()

func _physics_process(_delta: float) -> void:
	look_at(player.global_position)
	if can_shoot == 1:
		shoot()
		can_shoot = 0
		%Bullet_Timer_Enemy.start()

func shoot():
	const BULLET = preload("res://entities/projectiles/enemy_bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_transform = %Enemy_Gun.global_transform
	new_bullet.global_rotation = %Enemy_Gun.global_rotation
	add_sibling(new_bullet)
	#add_child(new_bullet)

func _on_bullet_timer_timeout() -> void:
	can_shoot = 1

func _on_health_component_health_depleted() -> void:
	queue_free()
