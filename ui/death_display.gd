extends CanvasLayer

@onready var new: Label = $OptionsContainer/MarginContainer/VBoxContainer/HBoxContainer/New
@onready var v_separator: VSeparator = $OptionsContainer/MarginContainer/VBoxContainer/HBoxContainer/VSeparator
@onready var score_number: Label = $OptionsContainer/MarginContainer/VBoxContainer/ScoreNumber
@onready var best_number: Label = $OptionsContainer/MarginContainer/VBoxContainer/BestNumber

var high_score : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_points(current) -> void:
	score_number.text = str(current)
	if current > high_score:
		new.show()
		v_separator.show()
		high_score = current
		
	best_number.text = str(high_score)


func _on_continue_pressed() -> void:
	get_tree().reload_current_scene()
