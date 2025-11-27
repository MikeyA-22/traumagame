extends Photo

#@onready var pos
func _ready() -> void:
	messages = ["[color=red]A BIRTHDAY CARD![/color]","[color=red] USE [color=green]P[/color] TO TOGGLE PHOTOBOOK![/color]"]
	sfx = preload("res://Music/sfx/pick up paper.MP3")
	#pos = position

func free() -> void:
	pass#SigBus.emit_signal("REVEALKEY", pos)
