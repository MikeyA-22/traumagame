extends Interactable

class_name Door


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SigBus.connect("DOOR", _open_door)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _open_door():
	print("DOORisOpen")
