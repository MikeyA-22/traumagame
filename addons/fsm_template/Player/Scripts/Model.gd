##PROCESSOR
extends Node
class_name PlayerModel

const SPEED = 5.0
const JUMP_VELOCITY = 5


@export var isGravity = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var dampener = 0.1

@onready var player = $".."
@onready var skeleton = %Skeleton3D
@onready var animator = $Skeleton3D/AnimationPlayer as AnimationPlayer
@onready var combat = $Combat as HumanoidCombat
@onready var active_weapon: Weapon = $RightHand/RightHand as Hand
#	@onready var anim_tree = $Skeleton3D/AnimationTree as AnimationTree

var current_state: State

@onready var moves = {
	"idle" : $Idle,
	"run" : $Run,
	"landing" : $Landing,
	"jump_start": $JumpStart,
	"midair": $Midair,
	"Hit1": $Hit1,
	"Hit2": $Hit2
}

func _ready() -> void:
	current_state = moves["idle"]
	for move in moves.values():
		move.player = player

func update(input: InputPackage, delta: float):
	input = combat.translate_combat_actions(input)
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
