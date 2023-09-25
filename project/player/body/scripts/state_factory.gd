class_name PlayerStateFactory
## A State Factory for creating new instances of player states.
##
## Creates and returns a reference to an active player state based on the input
## string. The dictionary of states contains these recognized strings and their
## associated state object/script.


var states


func _init():
	# add new states to the dictionary here
	states = {
		"idle": PlayerIdleState,
		"move": PlayerMoveState,
		"jump": PlayerJumpState,
		"fall": PlayerFallState,
		"crouch": PlayerCrouchState,
		"kick": PlayerKickState,
		
	}


func get_state(state_name):
	# if state_name is in the dictionary the associated object is returned
	if states.has(state_name):
		return states.get(state_name)
	else:
		printerr("No state ", state_name, " in state factory!")
