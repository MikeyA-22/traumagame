extends Control

@onready var progress_bar = $ProgressBar
@onready var loading_anim = $AnimatedSprite2D

var progress =[]
@export var scene_name: String
var scene_load_status = 0
var progress_value



func _ready() -> void:
	scene_name = Game_Global.loadable_scene
	ResourceLoader.load_threaded_request(scene_name)
	loading_anim.play("loading")
	

func _process(delta: float) -> void:
	scene_load_status = ResourceLoader.load_threaded_get_status(scene_name,progress)
	#countdown.text = str(floor(progress[0] * 100)) + "%"
	progress_value = progress[0] * 100
	progress_bar.value = move_toward(progress_bar.value, progress_value, delta * 20)

	
	# zip the progress bar to 100% so we don't get weird visuals
	
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		progress_bar.value = move_toward(progress_bar.value, 100.0, delta * 150)
		
	if progress_bar.value >= 99:
		var new_scene = ResourceLoader.load_threaded_get(scene_name)
		get_tree().change_scene_to_packed(new_scene)
