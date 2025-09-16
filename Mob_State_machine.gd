extends Node

@export var animation_player : AnimationPlayer
@export var character : CharacterBody3D
current move: AIstate

var states : Dictionary #{ String: AIMove }

func _ready() -> void:
	accept_states()
	current_state = states["idle"]
	switch_to("idle")



func _physics_process(delta: float) -> void:
	var verdict = current_move.check_transition(delta)
	if verdict[0]:
		switch_to(verdict[1])
	current_state.update(delta)


func switch_to(next_state_name: String):
	print(current_state.state_name + " -> " + next_state_name)
	current_state.on_exit()
	current_move = moves[next_state_name]
	
func accept_states():
	pass
