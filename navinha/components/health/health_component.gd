extends Node2D
class_name HealthComponent

signal health_changed(current: float, maximum: float)
signal health_depleted

var health: Pool
var on_fire:bool = false
var fire_damage:float = 0.0

@onready var fire_timer: Timer = %FireTimer
@onready var object: CanvasItem = get_parent()

static func of(node: Node) -> HealthComponent:
	return node.get_node_or_null(^"HealthComponent") as HealthComponent

func _ready() -> void:
	assert(health != null, "HealthComponent nao recebeu um Pool")
	health.changed.connect(_on_changed)
	health.depleted.connect(_on_depleted)
	health_changed.emit(health.current, health.maximum.value)


func _process(delta: float) -> void:
	health.regenerate(delta)
	if fire_damage > 0 and !on_fire:
		on_fire = true
		fire_timer.start()

func take_fire_damage(amount:float) -> void:
	health.drain(fire_damage)
	object.modulate = Color.RED
	await get_tree().create_timer(0.2).timeout
	object.modulate = Color.WHITE

func take_damage(amount: float) -> void:
	health.drain(amount)

func life_gain(amount: float) -> void:
	health.restore(amount)

func _on_changed(current: float, maximum: float) -> void:
	health_changed.emit(current, maximum)

func _on_depleted() -> void:
	health_depleted.emit()

func _on_fire_timer_timeout() -> void:
	take_fire_damage(fire_damage)
