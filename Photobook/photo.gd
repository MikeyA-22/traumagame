extends Pickable

class_name Photo

@export var photodata: PhotoData

func _ready() -> void:
	sfx = preload("res://Music/sfx/pick up paper.MP3")
