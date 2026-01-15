@tool
extends WorldEnvironment

@export var env: WorldEnvironment
@export var sub_view: SubViewport
@onready var in_game_env: Environment = preload("res://Tutorial Level/tutv2/main_env.tres")

@onready var editor_env: Environment = preload("res://Level 1/visible_env.tres")

func _ready() -> void:
	if Engine.is_editor_hint():
		env.environment = editor_env
		print("allo?")
	else:
		env.environment = in_game_env
		print("huh huh huhhh")
		sub_view.audio_listener_enable_3d
