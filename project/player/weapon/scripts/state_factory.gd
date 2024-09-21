class_name WeaponStateFactory
## A State Factory for creating new instances of player weapon states.
##
## Creates and returns a reference to an active player weapon state based on the 
## input string. The dictionary of states contains these recognized strings and 
## their associated state object/script.


var states


func _init():
	# add new states to the dictionary here
	states = {
		"empty_idle": WeaponEmptyIdleState,
		"gun_idle": WeaponGunIdleState,
		"gun_active": WeaponGunActiveState,
		"red_orb_idle": WeaponRedOrbIdleState,
		"red_orb_aim": WeaponRedOrbAimState,
		"red_orb_active": WeaponRedOrbActiveState,
		
	}


func get_state(state_name):
	# if state_name is in the dictionary the associated object is returned
	if states.has(state_name):
		return states.get(state_name)
	else:
		printerr("No state ", state_name, " in player weapon state factory!")
