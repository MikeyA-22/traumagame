extends Node
class_name State

@onready var player

var animation : String
var start_marker: String
var end_marker: String
var move_name: String
var dampener = 0.1
var enter_state_time: float
var has_queued_move: bool
var queued_move : String = "none, drop error please"


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var tracking_angular_speed : float = 10

static var state_priority : Dictionary = {
	"idle" : 1,
	"run" : 2,
	"jump_start" : 10,
	"midair" : 10,
	"landing" : 10,
	"Hit1" : 15,
	"Hit2": 15,
	"Flashlight" : 15,
	"Interacting": 15,
	"open_door": 15,
	"take_pills": 15,
	"blow_candles": 15,
	"hidden": 15
	}

static func priority_sort(a: String, b: String):
	if(state_priority[a] > state_priority[b]):
		return true
	else:
		return false

func on_enter_state():
	pass
func on_exit_state():
	pass
	
func update(input: InputPackage, delta : float):
	if !player.is_on_floor():
		player.velocity.y -= gravity * delta * dampener
		player.move_and_slide()
		
	
func check_request(input: InputPackage) -> String:
	var error_message = "error, not implemented"
	print_debug(error_message)
	return error_message
	
func mark_enter_state():
	enter_state_time = Time.get_unix_time_from_system()
	

func get_progress() -> float:
	var now = Time.get_unix_time_from_system()
	return now - enter_state_time
	
func works_longer_than(time: float) -> bool:
	if get_progress() >= time:
		return true
	return false

func works_less_than(time: float) -> bool:
	if get_progress() <= time:
		return true
	return false

func works_between(start: float, finish: float) -> bool:
	var progress = get_progress()
	if  progress >= start and progress <= finish:
		return true
	return false
	

func debugprintcurrentanimation():
	print(animation)
	
func printqueuedmove():
	print(queued_move)

func checkcombos(input : InputPackage):
	# works if only children we have are combos, use defined on ready array if not
	var available_combos = get_children()
	for combo : Combo in available_combos:
		if combo.is_triggered(input):
			has_queued_move = true
			queued_move = combo.triggered_move
