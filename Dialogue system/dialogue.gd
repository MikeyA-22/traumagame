extends Control

class_name Dialogue
@onready var background : NinePatchRect = $background
@onready var content : RichTextLabel = $content
@onready var type_timer : Timer = $typetimer
@onready var pause_timer : Timer = $pausetimer
@onready var audio_player : AudioStreamPlayer
@onready var pause_calc : PauseCalculator = $PauseCalculator

var playing_voice:bool

signal message_completed

func _init() -> void:
	modulate.a = 0
	var tween = create_tween()
	tween.tween_property(self,"modulate:a",1.0,1.0)

func _ready() -> void:
	
	await get_tree().create_timer(1.0).timeout
	
  
# Update the message and starts typing
func update_message(message: String) -> void:
	content.bbcode_text = pause_calc.extract_pauses_from_string(message)
	content.visible_characters = 0
	type_timer.start()
	playing_voice = true
	#audio_player.play(0)



func _on_typetimer_timeout() -> void:
	pause_calc.check_at_position(content.visible_characters)
	if content.visible_characters < content.text.length():
		content.visible_characters += 1
	else:
		playing_voice = false
		type_timer.stop()
		emit_signal("message_completed")
	
func on_DialogueVoicePlayer_finished() -> void:
	if playing_voice:
		pass#audio_player.play(0)
		

# Returns true if there are no pending characters to show
func message_is_fully_visible() -> bool:
	return content.visible_characters >= content.text.length() - 1


func on_PauseCalculator_pause_requested(duration: float)-> void:
	playing_voice = false
	type_timer.stop()
	pause_timer.wait_time = duration
	#print(duration)
	pause_timer.start()
	


func _on_pausetimer_timeout() -> void:
	playing_voice = true
	#audio_player.play(0)
	type_timer.start()
	
	
	
