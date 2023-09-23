class_name PlayerState
extends CharacterBody2D

var change_state
var animated_sprite
var persistent_state


# Called every physics tick. '_delta' is the elapsed time since the previous 
# tick.
func _physics_process(_delta):
	persistent_state.move_and_slide()


func setup(change_state_in, animated_sprite_in, persistent_state_in):
	change_state = change_state_in
	animated_sprite = animated_sprite_in
	persistent_state = persistent_state_in


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
