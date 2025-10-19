extends Node3D

@onready var dialogue_manager = $DialogueManager
@onready var dialogue_position = $DialoguePosition
@onready var next_label = $NextLabel

func _ready() -> void:
	next_label.visible = false
	#dialogue_manager.show_messages(["here we can put some important messages"], dialogue_position.position)
	SigBus.connect("PICKING_UP", on_object_picked)

func on_object_picked(messages: Array)->void:
	dialogue_manager.show_messages(messages
	, dialogue_position.position)

func on_DialogueManager_message_completed()->void:
	next_label.visible = true

func on_DialogueManager_message_requested()->void:
	next_label.visible = false
	
func on_DialogueManager_finished()->void:
	next_label.visible = false
