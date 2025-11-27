extends Control

@onready var StartButton = $StartButton
@onready var Settings = $Settings
@onready var Exit = $Exit
@onready var main_title = $AnimatedSprite2D

func _ready() -> void:
	StartButton.connect("pressed", Callable(self, "_on_StartButton_pressed"))
	Settings.connect("pressed", Callable(self,"_on_Settingsbutton_pressed"))
	Exit.connect("pressed", Callable(self,"_on_ExitButton_pressed"))
	main_title.play("animation")

func _on_StartButton_pressed():
	get_tree().change_scene_to_file("res://Tutorial Level/tutorial_level.tscn")

func _on_ExitButton_pressed():
	get_tree().quit()
	
func _on_Settingsbutton_pressed():
	pass#get_tree().change_scene_to_file()
