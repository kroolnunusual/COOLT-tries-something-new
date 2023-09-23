class_name PlayerJumpState
extends PlayerState


var jump_speed = -600
var min_jump_speed = 0
var move_speed = 800
var friction = 0.32

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	animated_sprite.play("jump")
	persistent_state.velocity.y = jump_speed
	if animated_sprite.flip_h:
		move_speed *= -1


func _physics_process(delta):
	# Add the gravity.
	if not persistent_state.is_on_floor():
		persistent_state.velocity.y += gravity * delta
	if persistent_state.velocity.y > min_jump_speed:
		change_state.call("fall")
	persistent_state.velocity.x *= friction
	super._physics_process(delta)


func move_left():
	if not animated_sprite.flip_h:
		animated_sprite.flip_h = not animated_sprite.flip_h
	persistent_state.velocity.x = move_speed


func move_right():
	if animated_sprite.flip_h:
		animated_sprite.flip_h = not animated_sprite.flip_h
	persistent_state.velocity.x = move_speed
