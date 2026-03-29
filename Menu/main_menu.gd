extends Control

@onready var StartButton = $StartButton
@onready var Settings = $Settings
@onready var Exit = $Exit
@onready var main_title = $AnimatedSprite2D

@export var anim_player : AnimationPlayer
@export var monster_anim_player : AnimationPlayer

var animation = "animation"

func _ready() -> void:
	StartButton.connect("pressed", Callable(self, "_on_StartButton_pressed"))
	Settings.connect("pressed", Callable(self,"_on_Settingsbutton_pressed"))
	Exit.connect("pressed", Callable(self,"_on_ExitButton_pressed"))
	main_title.play(animation)
	anim_player.play(animation)
	monster_anim_player.play("walk")
	

func _on_StartButton_pressed():
	if Game_Global.save_game !=  null:
		var error = DirAccess.remove_absolute(Game_Global.SAVE_PATH)
		if error == OK:
			print("File deleted successfully.")
		else:
			print("Error deleting file: ", error)
	Game_Global.save_game = SaveGame.new()
	Game_Global.loadable_scene = "res://Tutorial Level/tutorial_level.tscn"
	get_tree().change_scene_to_file("res://loading_screen.tscn")
	
	

func _on_ExitButton_pressed():
	get_tree().quit()
	
func _on_Settingsbutton_pressed():
	if Game_Global.save_game !=  null:
		Game_Global.loadable_scene = Game_Global.save_game.level
		get_tree().change_scene_to_file("res://loading_screen.tscn")
	else:
		pass
	
	
