extends Interactable

class_name Door

var current_scene:SceneState
@export var next_level : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SigBus.connect("DOOR", _open_door)


func get_interaction_data(player) -> Dictionary:
	if Game_Global.active_object is Key:
		return {
			"interactable": true,
			"sig": SigBus.DOOR,
			"sig_value": true,
			"reticle": 1
		}

	return { "interactable": false }
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _open_door(door:bool):
	Game_Global.loadable_scene = next_level
	get_tree().change_scene_to_file(Game_Global.loading_screen)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
