extends FlickerLight3D


@onready var root = $".."
@export var gpu_particles: Array[GPUParticles3D]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var isoff = root.isoff
	if(isoff == false):
		flicker(delta, light_multiplier)
		for particle in gpu_particles:
			particle.emitting = true
	else:
		var tween = create_tween()
		tween.tween_property(self,"light_energy",0.0,0.25)
		#print(light_energy)
		for particle in gpu_particles:
			particle.emitting = false
		
