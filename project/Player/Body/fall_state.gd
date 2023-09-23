class_name PlayerFallState
extends PlayerState


var min_jump_speed = 0
var move_speed = 800

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	animated_sprite.play("fall")


func _physics_process(delta):
	# Add the gravity.
	if not persistent_state.is_on_floor():
		persistent_state.velocity.y += gravity * delta
	else:
		animated_sprite.play("land")
		printerr("change to idle")
		change_state.call("idle")
	super._physics_process(delta)


func move_left():
	if not animated_sprite.flip_h:
		animated_sprite.flip_h = not animated_sprite.flip_h


func move_right():
	if animated_sprite.flip_h:
		animated_sprite.flip_h = not animated_sprite.flip_h
