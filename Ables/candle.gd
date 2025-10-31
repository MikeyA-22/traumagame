extends Interactable
class_name candle

@export var isoff:bool
func _ready() -> void:
	interactable_actions = {"light_action_pressed":"blow_candles"}
	SigBus.connect("BLOWN", turn_off_candles)
	

func turn_off_candles(is_off: bool):
	if is_off == true:
		isoff = true
	else: 
		isoff = false
	print(isoff)
