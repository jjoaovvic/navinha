extends CharacterBody2D

@export var xp_value:int = 0
var drop_rate: float
@export var HealthComponent : HealthComponent
@export var stats_component: StatsComponent
@onready var player: Player = get_tree().get_root().find_child("Player", true, false)
@onready var stats: ShipStats = stats_component.stats
var can_shoot = 0
@onready var bullet_timer: Timer = %Bullet_Timer_Enemy
@onready var gun: Marker2D = %Enemy_Gun

func _ready() -> void:
	bullet_timer.wait_time = stats.shot_interval()
	bullet_timer.start()

func _physics_process(_delta: float) -> void:
	look_at(player.global_position)
	if can_shoot == 1:
		shoot()
		can_shoot = 0
		bullet_timer.start()

func shoot():
	const BULLET = preload("res://entities/projectiles/enemy_bullet.tscn")
	var new_bullet: Node2D = BULLET.instantiate()
	new_bullet.global_transform = gun.global_transform
	new_bullet.global_rotation = gun.global_rotation
	add_sibling(new_bullet)
	#add_child(new_bullet)

func _on_bullet_timer_timeout() -> void:
	can_shoot = 1

func _on_health_component_health_depleted() -> void:
	player.xp_gain(xp_value)
	drop_rate = randf()
	if drop_rate > 0.9:
		call_deferred("spawn_life_pill")
	queue_free()

func spawn_life_pill() -> void:
	const LIFE_PILL: PackedScene = preload("res://entities/pickups/life_pill/life_pill.tscn")
	var pill: Node2D = LIFE_PILL.instantiate()
	pill.global_position = global_position
	get_tree().root.add_child(pill)
