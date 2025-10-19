extends Node

class_name Game_Global

static var is_pickable: bool =  false

static var current_pickable: Pickable
static var current_interactor: Interactable
static var flashlight_value: float

static var active_object

enum game_state{
	STATE_1,
	STATE_ENEMY_ATTACK,
}

static var current_gState: game_state = game_state.STATE_1
static var noise_int: float

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	RenderingServer.global_shader_parameter_set("static_noise_intensity", noise_int)
	
	#print(current_gState)
