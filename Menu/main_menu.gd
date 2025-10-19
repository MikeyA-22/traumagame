extends Control

@onready var StartButton = $ColorRect2/StartButton

func _ready() -> void:
	StartButton.connect("pressed", Callable(self, "_on_StartButton_pressed"))
	

func _on_StartButton_pressed():
	get_tree().change_scene_to_file("res://Tutorial Level/tutorial_level.tscn")
