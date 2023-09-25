class_name PlayerState
extends CharacterBody2D
## Base player state object.
##
## This is the state object which all other player states inherit from, except
## the persistence object; when "super" is called in other scripts it's 
## referencing methods and data found here.


# The active state
var change_state
# A reference to the player's PlayerAnimator component
var animated_sprite
# The persistent state object which the physics system acts on and which 
# contains our reused player variables.
var persistent_state


# Called every physics tick. '_delta' is the elapsed time since the previous 
# tick. Moves the player body according to active velocity info (velocity is 
# built in to CharacterBody2D, the parent class of this script)
func _physics_process(_delta):
	persistent_state.move_and_slide()


# Used to refresh states after the factory creates the new active object
func setup(change_state_in, animated_sprite_in, persistent_state_in):
	change_state = change_state_in
	animated_sprite = animated_sprite_in
	persistent_state = persistent_state_in


# Stubbed transition functions to prevent errors. If they're not callable in a
# derived state, that call ends up here and is passed.
func idle():
	pass


func move_left():
	pass

	
func move_right():
	pass


func jump():
	pass


func crouch():
	pass


func kick():
	pass


func fall():
	pass
