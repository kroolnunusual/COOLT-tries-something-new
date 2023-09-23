class_name PlayerStateFactory


var states


func _init():
	states = {
		"idle": PlayerIdleState,
		"move": PlayerMoveState,
		"jump": PlayerJumpState,
		"fall": PlayerFallState,
	}


func get_state(state_name):
	if states.has(state_name):
		return states.get(state_name)
	else:
		printerr("No state ", state_name, " in state factory!")
