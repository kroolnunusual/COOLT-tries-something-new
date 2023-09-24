class_name PlayerCrouchState
extends PlayerState


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	animated_sprite.play("crouch")


func _flip_direction():
	animated_sprite.flip_h = not animated_sprite.flip_h


func move_left():
	if not animated_sprite.flip_h:
		_flip_direction()


func move_right():
	if animated_sprite.flip_h:
		_flip_direction()


func jump():
	change_state.call("jump")


func idle():
	animated_sprite.play("reverse_crouch")
	change_state.call("idle")
