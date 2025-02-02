extends Node2D

@onready var top: RigidBody2D = $Top
@onready var bottom: RigidBody2D = $Bottom

@export var speed : int = 300

signal point_added

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.y = randi() % 201 + 80
	top.linear_velocity.x = -(speed)
	bottom.linear_velocity.x = -(speed)


func _on_point_detection_body_entered(body: Node2D) -> void:
	point_added.emit()
