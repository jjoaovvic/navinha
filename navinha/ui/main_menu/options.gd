extends CanvasLayer

@onready var menu: CanvasLayer = %Menu
@onready var options: CanvasLayer = %Options
@onready var start_button: Button = %StartButton


func _on_back_button_pressed() -> void:
	menu.visible = true
	options.visible = false
	start_button.grab_focus()
