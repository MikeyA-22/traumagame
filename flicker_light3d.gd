class_name FlickerLight3D extends Light3D


@export var noise: NoiseTexture3D
var time_passed := 0.0
@export var  light_multiplier: float  = 1


func flicker(delta, light_multiplier):
	time_passed += delta
		#print(time_passed)
	var sampled_noise = noise.noise.get_noise_1d(time_passed * 2)
	sampled_noise = abs(sampled_noise)
	light_energy = sampled_noise * light_multiplier
