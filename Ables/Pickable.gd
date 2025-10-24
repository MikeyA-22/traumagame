extends CharacterBody3D
class_name Pickable


@export var item_name: String
var pickable_action : Dictionary
@export var messages : Array[String]
const LAYER_INTERACTABLE = 1<<1
const MASK_PLAYER = 1<<0
const MASK_ENVIRONMENT = 1<<2
@export var pickable_float_range:float = 2
var pickable_area = Area3D.new()
var pickable_shape = SphereShape3D.new()
var pickable_range = CollisionShape3D.new()
var outline: ShaderMaterial = load("res://Shaders/Pickable.tres")
@export var mat_array : Array[StandardMaterial3D]
#@export var main_mat: StandardMaterial3D



func _init() -> void:
	add_indication_area()

func show_outline(body: Node3D)->void:
	if body is Player:
		print("In the scene")
		outline.set_shader_parameter("shader_parameter/outline_color", Vector3(1,1,1))
		outline.set_shader_parameter("shader_parameter/outline_width", 4.0)
		for mats in mat_array:
			mats.next_pass = outline

func hide_outline(body: Node3D)->void:
	if body is Player:
		print("outline is hidden")
		for mats in mat_array:
			mats.next_pass = null

func add_indication_area():
	collision_layer = LAYER_INTERACTABLE
	collision_mask = MASK_PLAYER | MASK_ENVIRONMENT
	##INTERACTION INDICATOR SETUP
	#A. SET RADIUS OF THE SHAPE REFERENCE FOR COLLISION
	pickable_shape.radius = pickable_float_range
	#B. SET SHAPE TO COLLISION SHAPE
	pickable_range.shape = pickable_shape
	#C. ADD COLLISION AS CHILD OF AREA
	pickable_area.add_child(pickable_range)
	#D. SET UP THE COLLISION
	pickable_area.connect("body_entered",Callable(self,"show_outline"))
	pickable_area.connect("body_exited",Callable(self,"hide_outline"))
	#E. ADD AREA AS CHILD
	add_child(pickable_area)
	

func remove_outline():
	for mats in mat_array:
		mats.next_pass = null
	pickable_area.queue_free()
