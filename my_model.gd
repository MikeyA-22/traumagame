##PROCESSOR
extends Node
class_name MyModel

const SPEED = 3.0
const JUMP_VELOCITY = 5


@export var isGravity = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var dampener = 0.1

@export var player : CharacterBody3D
@onready var skeleton = %GeneralSkeleton2
@onready var animator = $GeneralSkeleton2/AnimationPlayer as AnimationPlayer

@onready var active_object: Pickable
@onready var right_hand = $RightHand/Right
@onready var inventory = $Inventory as Node
@onready var Photobook = $Photobook
@onready var hidden

@onready var interaction_manager : InteractionManager = $InteractionMachine/InteractionManager

@onready var movement_machine : StateMachine = $MovementMachine
@onready var interaction_machine: StateMachine = $InteractionMachine


static var flash = false



var current_state: MyState


func _init() -> void:
	pass


	
func _ready() -> void:
	pass
	
	
	

func update(input: InputPackage, delta: float):
	
	movement_machine.update(input, delta)
	var input_interaction = interaction_manager.translate_pickable_actions(input)
	#print(input_interaction.interactions)
	interaction_machine.update(input_interaction, delta)













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
