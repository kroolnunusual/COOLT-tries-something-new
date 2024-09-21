class_name PlayerFallState
extends PlayerState
## Fall player state object.
##
## This is the state object which is active while the player is falling through
## the air, either post-jump or via other means.


func _ready():
	print_debug("BODY STATE - In fall")
	animation_player.play("fall")
	# transition to next state after landing animation, connected out of physics
	# tick to prevent multiple reconnect attempts firing
	animation_player.animation_finished.connect(_landing_anim_callback)


func _physics_process(delta):
	# Add the gravity.
	if not persistent_state.is_on_floor():
		persistent_state.velocity.y += persistent_state.gravity * delta
	else:
		animation_player.play("land")
	persistent_state.velocity.x *= persistent_state.friction
	super._physics_process(delta)


func _landing_anim_callback(_anim_name):
	if persistent_state.is_on_floor():
		# if there's any significant velocity we transition to move on touch-down
		if persistent_state.velocity.x < persistent_state.min_move_speed:
			change_state.call("idle")
		else:
			change_state.call("move")


func _flip_direction():
	sprite.flip_h = not sprite.flip_h


func move_left():
	if not sprite.flip_h:
		_flip_direction()
	persistent_state.velocity.x = persistent_state.move_speed * -1


func move_right():
	if sprite.flip_h:
		_flip_direction()
	persistent_state.velocity.x = persistent_state.move_speed
