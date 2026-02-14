extends FlickerLight3D

func _process(delta: float) -> void:
	if light_energy > 0:
		flicker(delta/2,light_multiplier)
		emit(true)
	else:
		emit(false)
	light_energy * light_multiplier
	
