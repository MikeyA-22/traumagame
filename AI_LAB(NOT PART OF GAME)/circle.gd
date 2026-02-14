@tool
extends Node2D

@export var centre: Vector2
@export var radius: float = 40
@export var color: Color = Color(255,0,255)

func _ready() -> void:
	
	_draw()



func _draw():
	var cen = centre
	var rad = radius
	var col = color
	draw_circle(cen,rad,col)
