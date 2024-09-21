class_name WeaponState
extends Node2D


var change_state
var animated_sprite
var persistent_state


func setup(change_state_in, animated_sprite_in, persistent_state_in):
	change_state = change_state_in
	animated_sprite = animated_sprite_in
	persistent_state = persistent_state_in


func fire():
	pass


func prev():
	print_debug("prev weapon")

	
func next():
	print_debug("next weapon")


func quick_select():
	pass
