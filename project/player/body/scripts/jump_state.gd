class_name PlayerJumpState
extends PlayerState
## Jumping player state object.
##
## This is the state object which is active while the player is beginning the
## arc of their jump, immediately after input through to the apex.


func _ready():
	animated_sprite.play("jump")
	# we want to apply full jump force at the beginning of the state
	persistent_state.velocity.y = persistent_state.jump_speed


func _physics_process(delta):
	# apply gravity as long as we're not grounded
	if not persistent_state.is_on_floor():
		persistent_state.velocity.y += persistent_state.gravity * delta
	else:
		change_state.call("idle")
	# as soon as we're no long moving up, we're falling
	if persistent_state.velocity.y > persistent_state.min_move_speed:
		change_state.call("fall")
	# decelerate left and right inputs
	persistent_state.velocity.x *= persistent_state.friction
	super._physics_process(delta)


func _flip_direction():
	animated_sprite.flip_h = not animated_sprite.flip_h


func move_left():
	# flip the sprite in the appropriate direction...
	if not animated_sprite.flip_h:
		_flip_direction()
	# ...and apply force (negative for left movement)
	persistent_state.velocity.x = persistent_state.move_speed * -1


func move_right():
	# ditto
	if animated_sprite.flip_h:
		_flip_direction()
	persistent_state.velocity.x = persistent_state.move_speed
