class_name PlayerPickupState
extends PlayerState
## Kick attack player state object.
##
## This is the state object which is active while the player is using the kick 
## attack. They'll become stationary while it's active and activate a hurt box.


func _ready():
	print_debug("BODY STATE - In pickup")
	animation_player.play("kick")
	# once the animation is finished, we transition to idle state
	animation_player.animation_finished.connect(_kick_anim_callback)


func _physics_process(delta):
	# dampen x axis movement coming from move (conversely disable this block
	# for a cool bug that could be used for a slide attack)
	persistent_state.velocity.x *= persistent_state.friction
	# call base physics tick
	super._physics_process(delta)


func _kick_anim_callback(_anim_name):
	change_state.call("idle")
