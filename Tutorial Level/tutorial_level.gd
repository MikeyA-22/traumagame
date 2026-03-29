extends Node3D

@onready var dialogue_manager = $DialogueManager
@onready var tut_dialogue_manager = $TutDialogueManager
@onready var dialogue_position = $DialoguePosition
@onready var next_label = $NextLabel
@export var photo:Photo

@export var key_data: ItemData

@export var player : Player

@export var current_level:int = 0


@export var monster_resource : PackedScene
var monster

@export var lightswitch : Light3D

@export var file_name :String

func _ready() -> void:
	next_label.visible = false
	call_deferred("initial_message")
	SigBus.connect("PICKING_UP", on_object_picked)
	photo.connect("picked_up", Callable(self,"reveal_key"))
	reset_params()
	if Game_Global.save_game != null:
		Game_Global.save_game.level = file_name
	
	

func initial_message():
	tut_dialogue_manager.show_message(["[color=red]WASD  or ARROW KEYS TO MOVE[/color]","[color=red] Use the [color=red] mouse to look around[/color]","[color=red]USE RIGHT CLICK[/color][color=red]  TO BLOW OUT THE CANDLES 
OR [/color][color=red]PICK UP THE FLASHLIGHT IN FRONT OF YOU![/color]"])
	#dialogue_manager.show_messages(["
#[color=red]WASD or Arrow keys[/color][color=red] TO MOVE[/color]",
#"[color=red] Use the [color=red] mouse to look around[/color]",
#"[color=red]RIGHT CLICK OR E[/color][color=red]  TO BLOW OUT THE CANDLES 
#THEN [/color][color=red]PICK UP THE FLASHLIGHT[/color]",
#"[color=red]LEFT CLICK OR Z[/color][color=red] TO USE ITEM IN HAND[/color]",
#"[color=red]ENTER[/color][color=red] TO PROGRESS DIALOGUE[/color]",
#"[color=red]SWITCH INVENTORY ITEMS WITH[/color] [color=red]TAB[/color]",
#"[color=red]GO TOWARDS THE[/color] [shake][color=red]CAKE![/color][/shake]",
#"[color=red]THERE SHOULD BE A [/color][color=red]FLASHLIGHT[/color][color=red]IN FRONT OF YOU.[/color]",
#"[color=red] LOOK FOR THE PHOTO AND THE KEY![/color]"], dialogue_position.position, 4.25)
	
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
	Game_Global.current_gState = Game_Global.game_state.STATE_ENEMY_ATTACK
	dialogue_manager.show_messages(["[color=red]USE Q TO STUN!!![/color]"],dialogue_position.position, 5.5)
	add_monster()
	
	
func _on_state_changer_body_entered(body: Node3D) -> void:
	print("reached")
	if body == player:
		
		dialogue_manager.show_messages(["[color=red] WATCH OUT FOR THE MONSTER!! [/color]","[color=red][shake rate=5 level=10]USE[color=red] Q [/color] TO STUN!!",
		"[color=red][shake rate=5 level=10] USE THE PILLS TO GET UR SANITY BACK!![/shake][/color]",
		"[color=red][shake rate=5 level=10] BUT BE CAREFUULLL!!!![/shake][/color]"]
		,dialogue_position.position,7)
		


func reset_params():
	RenderingServer.global_shader_parameter_set("heat_strength", 0)
	RenderingServer.global_shader_parameter_set("warp_strength", 0)
	Game_Global.current_gState = Game_Global.game_state.STATE_1


func _on_instruction_area_body_entered(body: Node3D) -> void:
	if body == player:
		dialogue_manager.show_messages(["[color=red]FIND THE [color=red] BIRTHDAY CARD!![/color][/color]"],dialogue_position.position,4.0)

func add_monster():
	lightswitch.light_color = Color.RED
	monster = monster_resource.instantiate()
	add_child(monster)
	player.monster = monster
	SigBus.SETMONSTER.emit(monster)
	print("PLAYER MONSTER IS: ", player.monster)
