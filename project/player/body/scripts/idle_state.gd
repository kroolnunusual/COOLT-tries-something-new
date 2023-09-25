class_name PlayerIdleState
extends PlayerState
## Idle player state object.
##
## This is the state object which is active while the player is not moving.


func _ready():
	animated_sprite.play("idle")


func _physics_process(_delta):
	# i don't know if this will come up, it's to cover moving platform edge cases
	if not persistent_state.is_on_floor():
		change_state.call("fall")


func _flip_direction():
	animated_sprite.flip_h = not animated_sprite.flip_h

func move_left():
	if not animated_sprite.flip_h:
		_flip_direction()
	change_state.call("move")

func move_right():
	if animated_sprite.flip_h:
		_flip_direction()
	change_state.call("move")


func jump():
	change_state.call("jump")


func crouch():
	change_state.call("crouch")
