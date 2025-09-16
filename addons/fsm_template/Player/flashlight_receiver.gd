extends SpotLight3D

class_name FlashlightReceptor

var flash_flag: bool

func _ready() -> void:
	light_energy = 0
	SigBus.connect("FLASH", on_flashlight)

func on_flashlight() -> void:
	flash_flag = !flash_flag
	if flash_flag == true:
		light_energy = 4
		#print(light_energy)
	else:
		light_energy = 0
		#print(light_energy)
