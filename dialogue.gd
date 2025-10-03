extends Control

class_name Dialogue
@export var background : NinePatchRect
@export var content : RichTextLabel
@export var type_timer : Timer
@export var pause_timer : Timer
@export var audio_player : AudioStreamPlayer
var playing_voice:bool

func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	update_message("[color=red]Hi I was generated for the dialogue system test for the godot game engine[/color]")
  
# Update the message and starts typing
func update_message(message: String) -> void:
	content.bbcode_text = message
	content.visible_characters = 0
	type_timer.start()
	playing_voice = true
	audio_player.play(0)



func _on_typetimer_timeout() -> void:
	if content.visible_characters < content.text.length():
		audio_player.play(0)
		content.visible_characters += 1
	else:
		type_timer.stop()
	
