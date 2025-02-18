extends Node2D

const OBSTACLE = preload("res://entities/obstacles/obstacle.tscn")

@export var obstacle_spawn_interval : float = 1.25

@onready var player: CharacterBody2D = $Player
@onready var ui: CanvasLayer = $UI

var player_is_alive : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.died.connect(_on_player_death)
	player.started.connect(_on_player_started)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(get_child_count())

func spawn_obstacle() -> void:
	
	if not player_is_alive:
		return
		
	var obstacle = OBSTACLE.instantiate()
	add_child(obstacle)
	obstacle.point_added.connect(_on_player_got_point)
	
	await get_tree().create_timer(obstacle_spawn_interval, false).timeout
	spawn_obstacle()


func _on_player_death() -> void:
	player_is_alive = false
	
	for obstacle in get_children():
		if obstacle is Obstacle:
			obstacle.slow()
	
	ui.show_game_over()

func _on_player_started() -> void:
	spawn_obstacle()
	ui.start_game()

func _on_player_got_point() -> void:
	ui.add_point()
