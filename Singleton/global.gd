extends Node

class_name Game_Global

static var is_pickable: bool =  false

static var current_pickable: Pickable
static var current_interactor: Interactable
static var flashlight_value: float
static var hidden: bool
static var active_object


enum game_state{
	STATE_1,
	STATE_ENEMY_ATTACK,
	STATE_END_GAME
}

static var current_gState: game_state = game_state.STATE_1
static var madness_increment: float

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	RenderingServer.global_shader_parameter_set("warp_strength", madness_increment)
	if madness_increment > 0.02:
		print("Game Over!!!")
		Game_Global.current_gState = game_state.STATE_END_GAME
		get_tree().change_scene_to_file("res://Menu/menu.tscn")
	
	#print(current_gState)
