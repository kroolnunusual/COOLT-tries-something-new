class_name PlayerMoveState
extends PlayerState


var move_speed = 800
var min_move_speed = 0.005
var friction = 0.32

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	animated_sprite.play("walk")
	if animated_sprite.flip_h:
		move_speed *= -1


func _physics_process(delta):
	# Add the gravity.
	if not persistent_state.is_on_floor():
		change_state.call("fall")
	if abs(persistent_state.velocity.x) < min_move_speed:
		change_state.call("idle")
	persistent_state.velocity.x *= friction
	super._physics_process(delta)


func move_left():
	if not animated_sprite.flip_h:
		change_state.call("idle")
	persistent_state.velocity.x = move_speed


func move_right():
	if animated_sprite.flip_h:
		change_state.call("idle")
	persistent_state.velocity.x = move_speed


func jump():
	change_state.call("jump")
