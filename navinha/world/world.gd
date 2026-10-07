extends Node2D
class_name World

@export var wave_quantity:int
var wave_in_progress : bool = false
var current_wave_number = 1
var paused:bool = false
@onready var game_over: CanvasLayer = %GameOver
@onready var upgrade: CanvasLayer = %Upgrade
@onready var pause: CanvasLayer = %Pause
@onready var pause_menu_button: Button = %MenuButton
@onready var player: Player = %Player
@onready var wave_manager: WaveManager = %WaveManager

func _ready() -> void:
	%GameOver.process_mode = Node.PROCESS_MODE_ALWAYS
	%Upgrade.process_mode = Node.PROCESS_MODE_ALWAYS
	%Pause.process_mode = Node.PROCESS_MODE_ALWAYS
	for button in upgrade_buttons():
		button.pressed.connect(_on_upgrade_button_pressed.bind(button))

func _process(_delta: float) -> void:
	if Input.is_action_pressed("restart"):
		_on_restart_button_pressed()


func upgrade_buttons() -> Array[UpgradeButton]:
	return [%UpgradeButton, %UpgradeButton2, %UpgradeButton3]

func set_upgrade() -> void:
	var picks := UpgradeCatalog.pick_random(upgrade_buttons().size())
	var buttons := upgrade_buttons()
	for i in buttons.size():
		buttons[i].set_upgrade(picks[i])

func _on_player_died() -> void:
	game_over.visible = true
	get_tree().paused = true

func _on_upgrade_button_pressed(button: UpgradeButton) -> void:
	button.call_upgrade(player.stats)
	get_tree().paused = false
	upgrade.visible = false

func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://ui/main_menu/main_menu.tscn")

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if paused == false:
			# 1. Ativa a pausa
			paused = true
			pause.visible = true
			pause_menu_button.grab_focus()
			get_tree().paused = true
		elif paused == true:
			# 1. Desativa a pausa
			paused = false
			pause.visible = false
			get_tree().paused = false


func _on_exit_button_pressed() -> void:
	get_tree().quit()
