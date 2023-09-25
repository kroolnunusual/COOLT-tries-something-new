class_name PlayerFallState
extends PlayerState
## Fall player state object.
##
## This is the state object which is active while the player is falling through
## the air, either post-jump or via other means.


func _ready():
	animated_sprite.play("fall")
	# transition to next state after landing animation, connected out of physics
	# tick to prevent multiple reconnect attempts firing
	animated_sprite.animation_finished.connect(_landing_anim_callback)


func _physics_process(delta):
	# Add the gravity.
	if not persistent_state.is_on_floor():
		persistent_state.velocity.y += persistent_state.gravity * delta
	else:
		animated_sprite.play("land")
	persistent_state.velocity.x *= persistent_state.friction
	super._physics_process(delta)


func _landing_anim_callback():
	if persistent_state.is_on_floor():
		# if there's any significant velocity we transition to move on touch-down
		if persistent_state.velocity.x < persistent_state.min_move_speed:
			change_state.call("idle")
		else:
			change_state.call("move")


func _flip_direction():
	animated_sprite.flip_h = not animated_sprite.flip_h


func move_left():
	if not animated_sprite.flip_h:
		_flip_direction()
	persistent_state.velocity.x = persistent_state.move_speed * -1


func move_right():
	if animated_sprite.flip_h:
		_flip_direction()
	persistent_state.velocity.x = persistent_state.move_speed
