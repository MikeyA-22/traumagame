extends Node

class_name Game_Global

static var is_pickable: bool =  false

static var current_pickable: Pickable
static var current_interactor: Interactable
static var flashlight_value: float
static var hidden: bool
static var active_object
static var current_gState: game_state = game_state.STATE_1
static var madness_increment: float
static var pills_amount: int = 5

static var loadable_scene: String
static var loading_screen: String = "res://loading_screen.tscn"

static var pressed: bool = true

static var active_tut_index = 0

const SAVE_PATH = "user://save.tres"


static var save_game: SaveGame = null


enum game_state{
	STATE_1,
	STATE_ENEMY_ATTACK,
	STATE_END_GAME
}


func _ready() -> void:
	if ResourceLoader.exists(SAVE_PATH):
		save_game = ResourceLoader.load(SAVE_PATH, "", ResourceLoader.CACHE_MODE_IGNORE)
	else:
		save_game = SaveGame.new()
	
func _process(delta: float) -> void:
	RenderingServer.global_shader_parameter_set("warp_strength", madness_increment)
	if madness_increment > 0.03:
		madness_increment = 0
		get_tree().change_scene_to_file("res://Menu/Game_over.tscn")
		current_gState = game_state.STATE_END_GAME
	#print(current_gState)
	
static func progress_tutorial():
	SigBus.TUT_KEY_PRESSED.emit()
	Game_Global.active_tut_index += 1
