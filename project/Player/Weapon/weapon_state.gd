class_name WeaponState
extends Node2D


var change_state
var animated_sprite
var persistent_state

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func setup(change_state_in, animated_sprite_in, persistent_state_in):
	change_state = change_state_in
	animated_sprite = animated_sprite_in
	persistent_state = persistent_state_in


func prev():
	pass

	
func next():
	pass


func quick_select():
	pass


func aim():
	pass


func fire():
	pass
