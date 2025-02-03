extends CanvasLayer

@onready var options: CanvasLayer = $MarginContainer/Options
@onready var points_label: Label = $MarginContainer/Points
@onready var to_play: RichTextLabel = $MarginContainer/ToPlay
@onready var death_display: CanvasLayer = $MarginContainer/DeathDisplay

var points : int = 0
var high_score : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		get_tree().paused = !get_tree().paused
		options.visible = !options.visible
		
func start_game() -> void:
	points_label.show()
	to_play.hide()


func _on_options_button_pressed() -> void:
	options.visible = !options.visible
	get_tree().paused = !get_tree().paused

func add_point() -> void:
	points += 1
	points_label.text = str(points)

func show_game_over() -> void:
	death_display.set_points(points)
	death_display.show()
