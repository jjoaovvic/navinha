extends Node2D

@onready var start_button: Button = %StartButton
@onready var menu: CanvasLayer = %Menu
@onready var options: CanvasLayer = %Options
@onready var back_button: Button = %BackButton

func _ready() -> void:
	start_button.grab_focus()

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://world/world.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_option_button_pressed() -> void:
	menu.visible = false
	options.visible = true
	back_button.grab_focus()
