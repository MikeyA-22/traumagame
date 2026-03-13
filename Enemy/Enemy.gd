extends CharacterBody3D

class_name Enemy

@export var player : CharacterBody3D

@export var animation_player : AnimationPlayer

@export_group("Speed Variables")
@export var speed : float = 3
@export var return_speed : float = 9

@export_group("AI radius")
@export var aggro_radius : float = 8
@export var attack_radius : float = 2
@export var deaggro_radius : float = 10



@export_group("Rooms")
@export var room_nodes: Array[Node]

#@onready var statemachine: MobStateMachine = $StateMachine
var spawn_point : Vector3

@onready var bt_root : root = $root
var blackboard : Dictionary
@onready var nav_agent : NavigationAgent3D = $NavigationAgent3D




func _ready():
	room_nodes = get_tree().get_nodes_in_group("rooms")
	player = get_tree().get_first_node_in_group("player")
	print(room_nodes)
	spawn_point = global_position
	blackboard = bt_root.blackboard
	blackboard.set("rooms", room_nodes)
	blackboard.set("spawn_point", spawn_point)
	blackboard.set("player", player)
	blackboard.set("animation_player", animation_player)
	blackboard.set("stunned", false)

func go_to_target(target, move_speed):
	var grounded_target_pos = target.global_position
	grounded_target_pos.y = target.global_position.y
	
	
	if nav_agent.target_position.distance_to(target.global_position) > 0.2:
		nav_agent.set_target_position(target.global_position)

	if nav_agent.is_navigation_finished():
		velocity = Vector3.ZERO
		return

	var next_pos = nav_agent.get_next_path_position()
	var delt = next_pos - global_position

	
	if delt.length() < 0.05:
		velocity = Vector3.ZERO
		return

	var direction = delt.normalized()
	velocity = direction * move_speed
	

	
	look_at(global_position + direction)

	move_and_slide()
