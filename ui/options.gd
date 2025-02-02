extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _on_return_pressed() -> void:
	hide()
	get_tree().paused = !get_tree().paused
