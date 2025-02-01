extends Node2D

@export var speed : int = 1000


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.y = randi() % 201 + 80



	
