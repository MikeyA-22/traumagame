class_name StateMachine
extends Node


@export var animation_tree: AnimationTree

@export var body : CharacterBody3D

@export var audio_player : AudioStreamPlayer3D

@export var state_machine_index : int

var current_state : MyState

var states : Dictionary

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var dampener = 0.1



func _ready() -> void:
	accept_states()
	current_state = states["idle"]
	
	
	
	
func update(input: InputPackage, delta: float):
	var requested = current_state.check_transition(input)
	#print(self.name + ": " + requested + " current state: ", current_state)
	if requested != "okay" and requested in states:
		switch_to(requested)
	current_state.update(input, delta)
	
	
	
	
	
	
func switch_to(next_state_name: String):
	#print(self.name + " " + current_state.state_name + " -> " + next_state_name)
	current_state.condition = false
	animation_tree.set("parameters/AnimationNodeStateMachine%d/conditions/%s" % [state_machine_index, current_state.condition_name], current_state.condition)
	#print("current state condition name: ", current_state.condition_name, " current state condition: ", current_state.condition)
	current_state.on_exit()
	current_state = states[next_state_name]
	current_state.mark_enter_state()
	current_state.on_enter()
	current_state.condition = true
	animation_tree.set("parameters/AnimationNodeStateMachine%d/conditions/%s" % [state_machine_index, current_state.condition_name], current_state.condition)
	#print("current state condition name: ", current_state.condition_name, " current state condition: ", current_state.condition)
	

func accept_states():
	for child in get_children():
		if child is MyState:
			states[child.state_name] = child
			child.body = body
			print(body)
			child.audio_player = audio_player
			
