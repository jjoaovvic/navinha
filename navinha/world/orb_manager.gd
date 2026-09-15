extends Node2D

@onready var player = get_tree().get_root().find_child("Player", true, false)
@export var orbit_radius: float = 100.0
@export var orbit_speed: float = 2.0
@export var orb_scene: PackedScene
@export var total_orbs: int = 5

var angle: float = 0.0
var orbs: Array[Node2D] = []

func _ready() -> void:
	for i in range(total_orbs):
		var orb = orb_scene.instantiate()
		add_child(orb)
		orbs.append(orb)

func _process(delta: float) -> void:
	if player == null:
		return
	angle = wrapf(angle + orbit_speed * delta, 0.0, TAU)
	for i in range(total_orbs):
		var angle_offset = i * (TAU / total_orbs)
		var offset = Vector2(cos(angle + angle_offset), sin(angle + angle_offset)) * orbit_radius
		orbs[i].global_position = player.global_position + offset
		orbs[i].rotation += 5 * delta
