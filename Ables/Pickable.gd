extends CharacterBody3D
class_name Pickable


@export var item_name: String
var pickable_action : Dictionary
@export var messages : Array[String]
const LAYER_INTERACTABLE = 1<<1
const MASK_PLAYER = 1<<0
const MASK_ENVIRONMENT = 1<<2
#var pickable_range = new(a)

func _init() -> void:
	collision_layer = LAYER_INTERACTABLE
	collision_mask = MASK_PLAYER | MASK_ENVIRONMENT
