extends Node2D

func _ready() -> void:
	$%StartButton.grab_focus()

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://world/world.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_option_button_pressed() -> void:
	%Menu.visible = false
	%Options.visible = true
	%BackButton.grab_focus()
