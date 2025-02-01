extends CharacterBody2D

@onready var death_explosion: GPUParticles2D = $DeathExplosion
@onready var sprite: Sprite2D = $Sprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer


const JUMP_VELOCITY = -225.0

var is_alive : bool = true

signal died

func _ready() -> void:
	animation_player.play("fall")

func _physics_process(delta: float) -> void:

	if not is_alive:
		return
	
	if is_on_ceiling() or is_on_floor() or is_on_wall():
		die()

	velocity += get_gravity() * delta
	sprite.rotation_degrees = lerp(sprite.rotation_degrees, 75.0, 0.01)
	

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
		sprite.rotation_degrees = -30
		animation_player.play("jump")
		

	move_and_slide()

func die() -> void:
	is_alive = false
	sprite.hide()
	death_explosion.restart()
	died.emit()




func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "jump":
		animation_player.play("fall")
