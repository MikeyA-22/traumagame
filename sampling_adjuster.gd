@tool
extends Control

signal add_object
signal show_objects

@export var my_mesh: MeshInstance3D
@onready var object_label:Label = $Background/objects
@onready var add_mat_button = $"Add Material Button"
@onready var show_mat_button = $"Show Material Button"
func _ready() -> void:
	add_mat_button.pressed.connect(_on_button_pressed)
	show_mat_button.pressed.connect(_on_show_button_pressed)
	

func _on_button_pressed():
	add_object.emit()
	
func _on_show_button_pressed():
	show_objects.emit()
