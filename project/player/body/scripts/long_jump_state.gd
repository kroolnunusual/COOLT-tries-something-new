class_name PlayerLongJumpState
extends PlayerState
## Jumping player state object.
##
## This is the state object which is active while the player is beginning the
## arc of their jump, immediately after input through to the apex.


func _ready():
	print_debug("BODY STATE - In long jump")
	animation_player.play("jump")
	# we want to apply full jump force at the beginning of the state
	persistent_state.velocity.y = persistent_state.long_jump_v_speed
	
	var horizontal_speed = persistent_state.long_jump_h_speed
	if sprite.flip_h:
		horizontal_speed *= -1
	
	persistent_state.velocity.x = horizontal_speed


func _physics_process(delta):
	# apply gravity as long as we're not grounded
	if not persistent_state.is_on_floor():
		persistent_state.velocity.y += persistent_state.gravity * delta
	# as soon as we're no long moving up, we're falling
	if persistent_state.velocity.y > persistent_state.min_jump_speed:
		change_state.call("fall")
	# decelerate left and right inputs
	persistent_state.velocity.x *= persistent_state.crouch_friction
	super._physics_process(delta)


func move_left():
	if (
		sprite.flip_h 
		and abs(persistent_state.velocity.x) < persistent_state.move_speed
	):
		# apply force (negative for left movement)
		persistent_state.velocity.x = persistent_state.move_speed * -1


func move_right():
	if (
		not sprite.flip_h 
		and abs(persistent_state.velocity.x) < persistent_state.move_speed
	):
		persistent_state.velocity.x = persistent_state.move_speed
