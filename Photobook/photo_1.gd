extends Photo

#@onready var pos
func _ready() -> void:
	messages = ["[color=red]A BIRTHDAY CARD![/color]","[color=red]CONTINUE FINDING PHOTOS AND PICTURES THROUGH THE LEVELS TO HELP SOLVE THE STORY!! [/color]"]
	sfx = preload("res://Music/sfx/pick up paper.MP3")
	#pos = position

func free() -> void:
	pass#SigBus.emit_signal("REVEALKEY", pos)
