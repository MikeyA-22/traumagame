@icon("res://Player/pointing.png")
extends Node3D

class_name Interactable

var interactable_actions: Dictionary


@export var interactable_float_range:float = 2

@export var indication_mouse_height: float = 0.5

var interactable_area = Area3D.new()
var interactable_shape = SphereShape3D.new()
var interactable_range = CollisionShape3D.new()
var pick_sfx: AudioStreamPlayer3D = AudioStreamPlayer3D.new()

var indicator_scene: PackedScene
var indicator : IndicatorMesh
var showing : bool = true
var hiding : bool = true

func get_interaction_data(player) -> Dictionary:
	return {}

func _init() -> void:
	add_indication_area()

func _ready() -> void:
	pass

func _notification(what: int) -> void:
	if what == NOTIFICATION_READY:
		setup_indicator()

func setup_indicator():
	indicator_scene = preload("res://Ables/indicator.tscn")
	indicator = indicator_scene.instantiate()
	add_child(indicator)
	indicator.position.y = indication_mouse_height

func show_indication():
	if indicator != null:
		if showing == true:
			indicator.animator.play("startindicate")
			print("INDICATIONSHOWING")
			showing = false
		

func remove_indication():
	if indicator != null:
		indicator.queue_free()

func hide_indication():
	if indicator != null:
		if showing == false:
			print("HIDINGINDICATION")
			indicator.animator.play("endindicate")
			showing = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_indication_area():

	##INTERACTION INDICATOR SETUP
	#A. SET RADIUS OF THE SHAPE REFERENCE FOR COLLISION
	interactable_shape.radius = interactable_float_range
	#B. SET SHAPE TO COLLISION SHAPE
	interactable_range.shape = interactable_shape
	#C. ADD COLLISION AS CHILD OF AREA
	interactable_area.add_child(interactable_range)
	#D. SET UP THE COLLISION
	interactable_area.connect("body_entered",Callable(self,"get_body_entered"))
	interactable_area.connect("body_exited",Callable(self,"get_body_exited"))
	#E. ADD AREA AS CHILD
	add_child(interactable_area)

func get_body_entered(body: Node3D):
	return body
	
func get_body_exited(body: Node3D):
	return body

func assign_sfx():
	add_child(pick_sfx)
	pick_sfx.stream = preload("res://Music/sfx/pick up.MP3")
	#pick_sfx.autoplay = true
	pick_sfx.volume_db = 10
	pick_sfx.max_db = 10
	pick_sfx.unit_size = 30
	print("Audio stream loaded:", pick_sfx.stream)
