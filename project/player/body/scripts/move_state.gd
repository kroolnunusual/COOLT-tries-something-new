class_name PlayerMoveState
extends PlayerState
## Walking player state object. (note: maybe i should rename this for clarity)
##
## This is the state object which is active while the player is walking across
## floor surfaces.


func _ready():
	animated_sprite.play("walk")


func _physics_process(delta):
	# if you're not on a floor, you're falling
	if not persistent_state.is_on_floor():
		change_state.call("fall")
	# if you're no longer moving, you're idle
	if abs(persistent_state.velocity.x) < persistent_state.min_move_speed:
		change_state.call("idle")
	# if you're still moving but there's no additional input, apply friction
	# to slow down
	persistent_state.velocity.x *= persistent_state.friction
	# call base physics tick
	super._physics_process(delta)


func move_left():
	# if you were facing right, switch back to idle
	if not animated_sprite.flip_h:
		change_state.call("idle")
	# otherwise, apply negative move speed to the x component of our velocity
	persistent_state.velocity.x = persistent_state.move_speed * -1


func move_right():
	# if you were facing left, switch back to idle
	if animated_sprite.flip_h:
		change_state.call("idle")
	# otherwise, apply move speed to the x component of our velocity
	persistent_state.velocity.x = persistent_state.move_speed


func jump():
	change_state.call("jump")


func kick():
	change_state.call("kick")
