extends Node

class_name Game_Global

static var is_pickable: bool =  false

static var current_pickable: Pickable
static var current_interactor: Interactable
static var flashlight_value: float

static var active_object

func _process(delta: float) -> void:
	if active_object != null and active_object.item_name != "Flashlight":
		SigBus.OFF_FLASH.emit()
		flashlight_value = 0
	
