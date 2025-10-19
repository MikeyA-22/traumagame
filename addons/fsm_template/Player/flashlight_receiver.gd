extends SpotLight3D

class_name FlashlightReceptor

var flash_flag: bool
@export var energy: float = 4

func _ready() -> void:
	light_energy = 0
	SigBus.connect("FLASH", on_flashlight)
	SigBus.connect("OFF_FLASH", off_flashlight)

func on_flashlight() -> void:
	
	flash_flag = !flash_flag
	if flash_flag == true:
		Game_Global.flashlight_value = energy
		light_energy = Game_Global.flashlight_value
		flash_flag = true
		#print(light_energy)
	else:
		off_flashlight()
	

func off_flashlight():
	
	Game_Global.flashlight_value = 0
	light_energy = Game_Global.flashlight_value
	flash_flag = false
		#print(light_energy)
