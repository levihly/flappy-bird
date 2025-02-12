extends Node2D

const OBSTACLE = preload("res://entities/obstacles/obstacle.tscn")

@export var obstacle_spawn_interval : float = 1.25
@export var obstacle_despawn_interval : float = 5.0

@onready var player: CharacterBody2D = $Player
@onready var ui: CanvasLayer = $UI

var player_is_alive : bool = true
var time_tween : Tween

signal game_started

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.died.connect(_on_player_death)
	player.started.connect(_on_player_started)
	if time_tween:
		time_tween.remove_all()
		
	Engine.time_scale = 1.0
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_obstacle() -> void:

		
	var obstacle = OBSTACLE.instantiate()
	add_child(obstacle)
	obstacle.point_added.connect(_on_player_got_point)
	
	
	
	await get_tree().create_timer(obstacle_spawn_interval, false).timeout
	spawn_obstacle()

	# delete self after time
	await get_tree().create_timer(obstacle_despawn_interval, false).timeout
	obstacle.queue_free()

func _on_player_death() -> void:
	player_is_alive = false
	time_tween = create_tween()
	time_tween.tween_property(Engine, "time_scale", 0.0, 0.5)
	ui.show_game_over()

func _on_player_started() -> void:
	spawn_obstacle()
	ui.start_game()

func _on_player_got_point() -> void:
	ui.add_point()
