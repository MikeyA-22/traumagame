extends RayCast3D

@onready var root = $"../Root"
@onready var model: PlayerModel = $".."
@onready var targetsphere = $targetsphere
@onready var fstep_player = $"../Fstep Player"

var current_surface_name: String = ""


@export var sound_mapping : Dictionary = {
	"Carpet" : preload("res://Music/footstep/carpet_1.MP3"),
	"Wood" : preload("res://Music/footstep/wood_2.MP3"),
	"CreakyWood" : preload("res://Music/footstep/Creeky wood_1.MP3"),
	"Concrete" : preload("res://Music/footstep/concrete_3.MP3")
}

func free() -> void:
	fstep_player.max_db = 20


func _process(delta: float) -> void:
	global_position = root.global_position
	targetsphere.global_position = get_collision_point()
	
	
	if model.current_state.name == "Run":
		change_footsteps()
		#play_footsteps()
	else:
		fstep_player.stream_paused = true


func change_footsteps():
	force_raycast_update()
	
	if is_colliding():
		
		var collider = get_collider()
		var surface_name
		if collider.is_in_group("Carpet"):
			surface_name = "Carpet"
		elif collider.is_in_group("Wood"):
			surface_name = "Wood"
		elif collider.is_in_group("CreakyWood"):
			surface_name = "CreakyWood"
		else:
			surface_name = "Concrete"
		
		if surface_name != current_surface_name:
			current_surface_name = surface_name
			if sound_mapping.has(surface_name):
				fstep_player.stream = sound_mapping[surface_name]
				fstep_player.play()
		
		print("Footstep is : ", fstep_player.stream, " Surface is: ", surface_name)
	
