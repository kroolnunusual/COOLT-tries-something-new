class_name PlayerPersistentState
extends CharacterBody2D
## Persistent player state object.
##
## This is the object which handles references to the current state, the state
## factory, and all player data that we'd expect to see persisted between 
## states; the velocity attribute of the parent CharacterBody2D is the most 
## important piece of that puzzle but we can also add any reused character 
## constant values.


# the currently active state
var state
# the instantiated state factory
var state_factory

# player constants
const min_jump_speed = 0
const min_move_speed = 0.3
const move_speed = 800
const jump_speed = -600
const friction = 0.32

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	# on ready, instantiate the state factory and use it to set the active state
	# to idle
	state_factory = PlayerStateFactory.new()
	change_state("idle")


# Input code was placed here for tutorial purposes. <-- FIX, DECOUPLE WITH SIGNALS?
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


# stubs that call through to the implementation on the active state
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


# based on the input state name: 
# 1. destroy the old state object
# 2. retrieve the new current state from the factory
# 3. setup the new active state with a callable reference to this function,
#    a reference to the player animator, and a reference to this persistent data
#    node
# 4. add it to scene
func change_state(new_state_name):
	if state != null:
		state.queue_free()
	state = state_factory.get_state(new_state_name).new()
	state.setup(Callable(self, "change_state"), $PlayerAnimator, self)
	state.name = "current_state"
	add_child(state)
