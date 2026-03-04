class_name MyState
extends Node

@export var state_name: String
@export var animation: String

@export var condition_name : String

var condition : bool = true



var body : CharacterBody3D



var resources : PlayerResources

var audio_player : AudioStreamPlayer3D

var enter_state_time : float

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.




		
func check_transition(input: InputPackage) -> String:
	var error_message = "error, not implemented"
	print_debug(error_message)
	return error_message


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

## ALL STATES HAVE AN UPDATE
func update(input, delta):
	pass
	
func on_enter():
	pass


func on_exit():
	pass
	
	
# our little timestamps framework to work with timings inside our logic
func mark_enter_state():
	enter_state_time = Time.get_unix_time_from_system()

func get_progress() -> float:
	var now = Time.get_unix_time_from_system()
	return now - enter_state_time

func works_longer_than(time : float) -> bool:
	if get_progress() >= time:
		return true
	return false

func works_less_than(time : float) -> bool:
	if get_progress() < time: 
		return true
	return false

func works_between(start : float, finish : float) -> bool:
	var progress = get_progress()
	if progress >= start and progress <= finish:
		return true
	return false
	
