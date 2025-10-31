extends Node3D

@onready var dialogue_manager = $DialogueManager
@onready var dialogue_position = $DialoguePosition
@onready var next_label = $NextLabel

@onready var player = $Player

func _ready() -> void:
	next_label.visible = false
	call_deferred("initial_message")
	SigBus.connect("PICKING_UP", on_object_picked)

func initial_message():
	dialogue_manager.show_messages(["
[color=green]WASD[/color][color=red] TO MOVE[/color]
[color=green]RIGHT CLICK[/color][color=red] TO INTERACT[/color]
[color=green]LEFT CLICK[/color][color=red] TO USE ITEM IN HAND[/color]
[color=green]ENTER[/color][color=red] TO PROGRESS DIALOGUE[/color]
[color=red]SWITCH ITEMS WITH[/color] [color=green]TAB[/color]
[color=red]GO TOWARDS THE[/color] [shake][color=green]CAKE![/color][/shake]"], dialogue_position.position)
	
func on_object_picked(messages: Array)->void:
	dialogue_manager.show_messages(messages
	, dialogue_position.position)

func on_DialogueManager_message_completed()->void:
	next_label.visible = true

func on_DialogueManager_message_requested()->void:
	next_label.visible = false
	
func on_DialogueManager_finished()->void:
	next_label.visible = false


func _on_state_changer_body_entered(body: Node3D) -> void:
	print("reached")
	if body == player:
		#print("working")
		Game_Global.current_gState = Game_Global.game_state.STATE_ENEMY_ATTACK
