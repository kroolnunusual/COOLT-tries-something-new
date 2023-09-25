class_name PlayerCrouchState
extends PlayerState
## Crouch player state object.
##
## This is the state object which is active while the player is crouching, and
## will transition out once the input is released.


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


func kick():
	change_state.call("kick")


func idle():
	animated_sprite.play("reverse_crouch")
	# once the animation is finished, we transition to idle state
	animated_sprite.animation_finished.connect(_idle_anim_callback)


func _idle_anim_callback():
	change_state.call("idle")
