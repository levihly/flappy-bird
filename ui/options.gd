extends CanvasLayer

@onready var enable_music: CheckBox = $OptionsContainer/MarginContainer/VBoxContainer/EnableMusic
@onready var enable_sound: CheckBox = $OptionsContainer/MarginContainer/VBoxContainer/EnableSound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _on_return_pressed() -> void:
	hide()
	get_tree().paused = false
	print('pressed')


func _on_main_menu_pressed() -> void:
	get_tree().reload_current_scene()
