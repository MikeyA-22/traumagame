@icon("res://Player/pointing.png")
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
#var outline: ShaderMaterial = load("res://Shaders/Pickable.tres")
var pick_sfx: AudioStreamPlayer3D = AudioStreamPlayer3D.new()
var sfx = preload("res://Music/sfx/pick up.MP3")
var interaction_label: Label = Label.new()
@export var mat_array : Array[StandardMaterial3D]

#@export var main_mat: StandardMaterial3D



func _init() -> void:
	add_indication_area()
	assign_sfx()

func show_outline(body: Node3D)->void:
	if body is Player:
		print("In the scene")
		for mats in mat_array:
			mats.stencil_mode = BaseMaterial3D.STENCIL_MODE_OUTLINE
			mats.stencil_color = Color.YELLOW
			mats.stencil_outline_thickness = 0.025

func hide_outline(body: Node3D)->void:
	if body is Player:
		print("outline is hidden")
		for mats in mat_array:
			mats.stencil_color = BaseMaterial3D.STENCIL_MODE_DISABLED

func label_setup():
	pass

func assign_sfx():
	add_child(pick_sfx)
	pick_sfx.stream = preload("res://Music/sfx/pick up.MP3")
	#pick_sfx.autoplay = true
	pick_sfx.volume_db = 10
	pick_sfx.max_db = 10
	pick_sfx.unit_size = 30
	print("Audio stream loaded:", pick_sfx.stream)


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
	

func on_picked():
	play_sfx()

func play_sfx():
	print("playing pickup?")
	print("Inside tree:", pick_sfx.is_inside_tree())
	print("Stream valid:", pick_sfx.stream)
	pick_sfx.play()
	print("Is playing:", pick_sfx.is_playing())

func free() -> void:
	play_sfx()
