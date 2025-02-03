extends CharacterBody2D

@onready var death_explosion: GPUParticles2D = $DeathExplosion
@onready var sprite: Sprite2D = $Sprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer


const JUMP_VELOCITY = -325.0

var is_alive : bool = true
var is_playing : bool = false

@onready var default_pos = get_position()

signal died
signal started

func _ready() -> void:
	is_alive = true
	is_playing = false
	animation_player.play("fall")
	set_collision_layer_value(1, true)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and not is_playing:
		is_playing = true
		sprite.material.set_shader_parameter("speed", 0)
		started.emit()

func _physics_process(delta: float) -> void:

	if not is_alive or not is_playing:
		return
	
	if is_on_ceiling() or is_on_floor() or is_on_wall():
		die()

	velocity += get_gravity() * delta
	rotation_degrees = lerp(rotation_degrees, 75.0, 0.01)
	

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
		rotation_degrees = -30
		animation_player.play("jump")
		

	move_and_slide()

func die() -> void:
	print("died")
	is_alive = false
	sprite.hide()
	set_collision_layer_value(1, false)
	death_explosion.restart()
	died.emit()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "jump":
		animation_player.play("fall")
