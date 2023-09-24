class_name PlayerPersistentState
extends CharacterBody2D


var state
var state_factory


func _ready():
	state_factory = PlayerStateFactory.new()
	change_state("idle")


# Input code was placed here for tutorial purposes. <-- FIX
func _process(_delta):
	if Input.is_action_pressed("player_left"):
		move_left()
	if Input.is_action_pressed("player_right"):
		move_right()
	if Input.is_action_pressed("player_jump"):
		jump()
	if Input.is_action_pressed("player_down"):
		crouch()
	if Input.is_action_just_released("player_down"):
		idle()


func move_left():
	state.move_left()


func move_right():
	state.move_right()


func jump():
	state.jump()


func crouch():
	state.crouch()


func idle():
	state.idle()


func kick():
	state.kick()


func fall():
	state.fall()


func change_state(new_state_name):
	if state != null:
		state.queue_free()
	state = state_factory.get_state(new_state_name).new()
	state.setup(Callable(self, "change_state"), $PlayerAnimator, self)
	state.name = "current_state"
	add_child(state)
