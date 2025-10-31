@icon("res://Player/pointing.png")
extends Node

class_name Interactable

var interactable_actions: Dictionary


@export var interactable_float_range:float = 2
var interactable_area = Area3D.new()
var interactable_shape = SphereShape3D.new()
var interactable_range = CollisionShape3D.new()

func _ready() -> void:
	add_indication_area()


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
	interactable_area.add_child(interactable_area)
	#D. SET UP THE COLLISION
	interactable_area.connect("body_entered",Callable(self,"get_body_entered"))
	interactable_area.connect("body_exited",Callable(self,"get_body_exited"))
	#E. ADD AREA AS CHILD
	add_child(interactable_area)

func get_body_entered(body: Node3D):
	return body
	
func get_body_exited(body: Node3D):
	return body
