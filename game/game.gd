extends Node2D

const OBSTACLE = preload("res://entities/obstacles/obstacle.tscn")

@export var obstacle_spawn_interval : float = 1.5
@export var obstacle_despawn_interval : float = 5.0

@onready var player: CharacterBody2D = $Player

var player_is_alive : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.died.connect(_on_player_death)
	spawn_obstacle()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_obstacle() -> void:

		
	var obstacle = OBSTACLE.instantiate()
	add_child(obstacle)
	
	
	
	await get_tree().create_timer(obstacle_spawn_interval, false).timeout
	spawn_obstacle()

	# delete self after time
	await get_tree().create_timer(obstacle_despawn_interval, false).timeout
	obstacle.queue_free()

func _on_player_death() -> void:
	player_is_alive = false
	var tween = get_tree().create_tween()
	tween.tween_property(Engine, "time_scale", 0.0, 0.6)
	
	
