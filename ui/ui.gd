extends CanvasLayer

@onready var options: CanvasLayer = $MarginContainer/Options
@onready var points: Label = $MarginContainer/Points

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	points.hide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		get_tree().paused = !get_tree().paused
		options.visible = !options.visible
