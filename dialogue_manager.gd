class_name DialogueManager
extends Node

const DIALOGUE_SCENE = preload("res://dialogue.tscn")

@onready var opacity_tween : Tween 



var messages = []
var active_dialogue_offset = 0
var is_active = false
var cur_dialogue_instance : Dialogue


func show_messages(message_list: Array, position: Vector2) -> void:
	# Only allow triggering if its not currently showing something
	if is_active:
		return
	is_active = true
	
	messages = message_list
	active_dialogue_offset = 0
	
	var _dialogue = DIALOGUE_SCENE.instance()
	_dialogue.connect(
		"message_completed", 
		self, 
		"_on_message_completed"
	)
	get_tree().get_root().add_child(_dialogue)
	
	cur_dialogue_instance = _dialogue
	
	show_current()
	
func show_current() -> void:
	SigBus.message_request.emit()
	var msg = messages[active_dialogue_offset] as String
	cur_dialogue_instance.update_message(msg)
	
	
func _input(event: InputEvent) -> void:
	if (
		event.is_action_pressed("enter") and
		is_active and
		cur_dialogue_instance.message_is_fully_visible()
	):
		if active_dialogue_offset < messages.size() - 1:
			active_dialogue_offset += 1
			show_current()
		else:
			hide()
			
func hide() -> void:
	#cur_dialogue_instance.disconnect(Callable(self, "message_completed"))
	cur_dialogue_instance.queue_free()
	cur_dialogue_instance = null
	is_active = false
	emit_signal("finished")
	
func on_message_completed():
	SigBus.message_completed.emit()
