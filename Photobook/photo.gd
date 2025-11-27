extends Pickable

class_name Photo

@export var photodata: PhotoData

signal picked_up(pos)

func _ready() -> void:
	pass


func on_photo_picked():
	emit_signal("picked_up", global_position)
	
