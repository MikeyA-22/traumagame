extends Node3D

@onready var dialogue_manager = $DialogueManager
@onready var dialogue_position = $DialoguePosition
@onready var next_label = $NextLabel
@export var photo:Photo

@export var key_data: ItemData

@onready var player = $Player

func _ready() -> void:
	next_label.visible = false
	call_deferred("initial_message")
	SigBus.connect("PICKING_UP", on_object_picked)
	photo.connect("picked_up", Callable(self,"reveal_key"))
	reset_params()
	#SigBus.connect("REVEALKEY", reveal_key)

func initial_message():
	dialogue_manager.show_messages(["
[color=green]WASD or Arrow keys[/color][color=red] TO MOVE[/color]",
"[color=red] Use the [color=green] mouse to look around[/color]",
"[color=green]RIGHT CLICK OR E[/color][color=red]  TO INTERACT[/color]",
"[color=green]LEFT CLICK OR Z[/color][color=red] TO USE ITEM IN HAND[/color]",
"[color=green]ENTER[/color][color=red] TO PROGRESS DIALOGUE[/color]",
"[color=red]SWITCH INVENTORY ITEMS WITH[/color] [color=green]TAB[/color]",
"[color=red]GO TOWARDS THE[/color] [shake][color=green]CAKE![/color][/shake]",
"[color=red]THERE SHOULD BE A [/color][color=green]FLASHLIGHT[/color][color=red]IN FRONT OF YOU.[/color]",
"[color=green] LOOK FOR THE PHOTO AND THE KEY![/color]"], dialogue_position.position, 4.25)
	
func on_object_picked(messages: Array, time: float)->void:
	dialogue_manager.show_messages(messages
	, dialogue_position.position,time)

func on_DialogueManager_message_completed()->void:
	next_label.visible = true

func on_DialogueManager_message_requested()->void:
	next_label.visible = false
	
func on_DialogueManager_finished()->void:
	next_label.visible = false

func reveal_key(pos):
	var key_scene = load("res://Ables/Key/key.tscn")
	var key = key_scene.instantiate()
	add_child(key)

	key.global_position = pos
	print("key pos: ", key.global_position)
	
	
func _on_state_changer_body_entered(body: Node3D) -> void:
	print("reached")
	if body == player:
		#print("working")
		Game_Global.current_gState = Game_Global.game_state.STATE_ENEMY_ATTACK
		dialogue_manager.show_messages(["[color=red] [shake rate=5 level=10] IT'S AFTER YOU NOW!![/shake][/color]",
		"[color=red][shake rate=5 level=10] GO FIND THE PILLS TO GET UR SANITY BACK!![/shake][/color]",
		"[color=red][shake rate=5 level=10]USE[color=green] Q [/color] TO STUN!!",
		 "[color=red][shake rate=5 level=10]OR GO HIDE AT THE TABLE NEXT TO THE TV!! [/shake][/color]",
		"[color=red][shake rate=5 level=10] BUT BE CAREFUULLL!!!![/shake][/color]"]
		,dialogue_position.position,4.25)
		


func reset_params():
	RenderingServer.global_shader_parameter_set("heat_strength", 0)
	RenderingServer.global_shader_parameter_set("warp_strength", 0)
	Game_Global.current_gState = Game_Global.game_state.STATE_1


func _on_instruction_area_body_entered(body: Node3D) -> void:
	if body == player:
		dialogue_manager.show_messages(["[color=red]FIND THE [color=green]PILLS AND THE BIRTHDAY CARD!![/color][/color]"],dialogue_position.position,4.25)
