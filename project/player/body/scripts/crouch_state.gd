class_name PlayerCrouchState
extends PlayerState
## Crouch player state object.
##
## This is the state object which is active while the player is crouching, and
## will transition out once the input is released.


func _ready():
	print_debug("BODY STATE - In crouch")
	animation_player.play("crouch")


func _physics_process(delta):
	# if you're not on a floor, you're falling
	if not persistent_state.is_on_floor():
		change_state.call("fall")
	# apply friction to slow down
	persistent_state.velocity.x *= persistent_state.crouch_friction
	# call base physics tick
	super._physics_process(delta)


func _flip_direction():
	sprite.flip_h = not sprite.flip_h


func move_left():
	if not sprite.flip_h:
		_flip_direction()


func move_right():
	if sprite.flip_h:
		_flip_direction()


func jump():
	if abs(persistent_state.velocity.x) > persistent_state.min_move_speed:
		print_debug(persistent_state.velocity.x)
		change_state.call("long_jump")
	else:
		change_state.call("high_jump")


func kick():
	change_state.call("kick")


func idle():
	animation_player.play_backwards("crouch")
	# once the animation is finished, we transition to idle state
	animation_player.animation_finished.connect(_idle_anim_callback)


func _idle_anim_callback(_anim_name):
	change_state.call("idle")
