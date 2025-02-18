class_name Obstacle extends Node2D

@onready var top: RigidBody2D = $Top
@onready var bottom: RigidBody2D = $Bottom

@export var speed : int = 300

signal point_added

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	position.y = randi() % 201 + 80
	top.linear_velocity.x = -(speed)
	bottom.linear_velocity.x = -(speed)

func slow() -> void:
	var top_tween = get_tree().create_tween()
	var bottom_tween = get_tree().create_tween()
	top_tween.tween_property(top, "linear_velocity", Vector2.ZERO, 2.5)
	bottom_tween.tween_property(bottom, "linear_velocity", Vector2.ZERO, 2.5)


func _on_point_detection_body_entered(body: Node2D) -> void:
	point_added.emit()


func _on_visible_on_screen_notifier_screen_exited() -> void:
	print('left screen')
	queue_free()


func _on_visible_on_screen_notifier_screen_entered() -> void:
	print('entered screen')
