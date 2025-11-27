extends Control

class_name GOverscreen

@onready var StartButton = $"ColorRect2/return to menu"

func _ready() -> void:
	Game_Global.current_gState = Game_Global.game_state.STATE_1
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	StartButton.connect("pressed", Callable(self, "_on_StartButton_pressed"))
	

func _on_StartButton_pressed():
	print("tomainmenu")
	get_tree().change_scene_to_file("res://Menu/menu.tscn")
