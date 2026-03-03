class_name TutorialDialogueManager
extends Node


const DIALOGUE_SCENE = preload("res://Dialogue system/dialogue.tscn")

@onready var opacity_tween : Tween 
var current_messages
var is_active
var cur_dialogue_instance : Dialogue
var active_dialogue_offset = 0

signal finished
signal message_completed



func show_message(messages: Array):
	if is_active:
		return
	is_active = true
	
	
	print("Print Active tut_index: ", Game_Global.active_tut_index)
	
	current_messages = messages
	var _dialogue = DIALOGUE_SCENE.instantiate()
	SigBus.connect("TUT_KEY_PRESSED", on_tut_key_pressed)
	
	_dialogue.connect(
		"finished",
		Callable(self,"on_finished"))
	
	_dialogue.connect(
		"message_completed", 
		Callable(self, "on_message_completed") 
		
	)
	
	get_tree().get_root().add_child(_dialogue)
	
	cur_dialogue_instance = _dialogue
	
	show_current()
	

func hide() -> void:
	cur_dialogue_instance.disconnect("message_completed", Callable(self, "on_message_completed"))
	
	var tween = create_tween()
	tween.tween_property(cur_dialogue_instance, "modulate:a", 0, 1.0)
	await tween.finished
	if is_instance_valid(cur_dialogue_instance):
		cur_dialogue_instance.queue_free()
	cur_dialogue_instance = null
	is_active = false
	emit_signal("finished")


func show_current() -> void:
	var msg = current_messages[active_dialogue_offset] as String
	cur_dialogue_instance.update_message(msg)


func on_tut_key_pressed():
	if active_dialogue_offset < current_messages.size() - 1:
		active_dialogue_offset += 1
		show_current()
		#print("going to next message")
	else:
		hide()
		
		
func on_message_completed():
	emit_signal("message_completed")
	
func on_finished():
	if active_dialogue_offset < current_messages.size() - 1:
		active_dialogue_offset += 1
		show_current()
		#print("going to next message")
	else:
		hide()
