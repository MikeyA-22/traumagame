##PROCESSOR
extends Node
class_name PlayerModel

const SPEED = 3.0
const JUMP_VELOCITY = 5


@export var isGravity = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var dampener = 0.1

@onready var player = $".."
@onready var skeleton = %Skeleton3D
@onready var animator = $Skeleton3D/AnimationPlayer as AnimationPlayer
#@onready var combat = $Combat as HumanoidCombat
@onready var interact = $InteractManager as Interact
#@export var objects : Array[Pickable]
@onready var active_object: Pickable
@onready var right_hand = $RightHand
@onready var inventory = $Inventory as Node
@onready var Photobook = $Photobook
#@onready var light = $"LocalCamera/Camera3D/Flashlight Receiver"

static var flash = false

#	@onready var anim_tree = $Skeleton3D/AnimationTree as AnimationTree

var current_state: State

@onready var moves = {
	"idle" : $Idle,
	"run" : $Run,
	"landing" : $Landing,
	"midair": $Midair,
	"Flashlight": $Flashlight,
	"Interacting": $Interacting,
	"open_door": $OpenDoor,
	"take_pills": $Pills,
	"blow_candles": $BlowCandles
}

func _ready() -> void:
	current_state = moves["idle"]
	for move in moves.values():
		move.player = player
		

func update(input: InputPackage, delta: float):
	input = interact.translate_pickable_actions(input)
	var requested = current_state.check_request(input)
	if requested != "okay":
		switch_to(requested)
	current_state.update(input, delta)
	
	

func switch_to(state: String):
	current_state.on_exit_state()
	current_state = moves[state]
	current_state.on_enter_state()
	current_state.mark_enter_state()
	animator.play_section_with_markers(current_state.animation,current_state.start_marker,current_state.end_marker)




	


	
	
	

func remove_pickable(object: Pickable):
	pass#objects.erase(object)

func set_active_object(object: Pickable):
		pass
		#Game_Global.active_object = object
		#active_object = object
		##object.basis = right_hand.basis
		#object.reparent(right_hand)
		#object.transform = right_hand.transform
		#object.position = Vector3.ZERO
		#
		#
		#
		#
