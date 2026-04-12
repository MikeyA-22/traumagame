extends Node3D

class_name LevelScript

@export var player: Player
@export var spawn_point : Node3D

var monster_resource = preload("res://Enemy/BT_base_enemy.tscn")



var monster : Enemy

@export var dialogue_manager : DialogueManager

@export var dialogue_position : Node2D
@export var next_label : Label 
@export var photo:Photo

@export var key_data: ItemData

@export var path_wall : Node3D


@export var current_level:int = 0

@export var door : Node3D

@export var area3D: Area3D

@export var file_name : String


func _ready() -> void:
	next_label.visible = false
	#call_deferred("initial_message")
	SigBus.connect("PICKING_UP", on_object_picked)
	if photo != null:
		photo.connect("picked_up", Callable(self,"reveal_path"))
	reset_params()
	if Game_Global.save_game != null:
		Game_Global.save_game.level = file_name
	spawn_monster()
	Game_Global.current_gState = Game_Global.game_state.STATE_ENEMY_ATTACK
	




func spawn_monster():
	monster = monster_resource.instantiate()
	monster.position = spawn_point.position
	add_child(monster)
	player.monster = monster
	SigBus.SETMONSTER.emit(monster)

func on_DialogueManager_message_completed()->void:
	next_label.visible = true

func on_DialogueManager_message_requested()->void:
	next_label.visible = false
	
func on_DialogueManager_finished()->void:
	next_label.visible = false

func on_object_picked(messages: Array, time: float)->void:
	dialogue_manager.show_messages(messages
	, dialogue_position.position,time)
	
func reset_params():
	RenderingServer.global_shader_parameter_set("heat_strength", 0)
	RenderingServer.global_shader_parameter_set("warp_strength", 0)
	Game_Global.current_gState = Game_Global.game_state.STATE_1




func _on_photo_picked_up(pos: Variant) -> void:
	if path_wall != null:
		path_wall.queue_free()


func _on_photo2_picked_up(pos: Variant) -> void:
	#if key_data != null:
		#var key : Pickable =  key_data.item_model.instantiate()
		#add_child(key)
		#key.position = pos
	if area3D != null:
		print("Activating area!!!")
		area3D.process_mode = Node.PROCESS_MODE_INHERIT
	
	


func _on_area_3d_body_entered(body: Node3D) -> void:
	print("made it here!!")
	print("name is: ", body.name)
	if body.name == "Player":
		print("made it into first wall")
		if door != null:
			print("Activating door!!!")
			door.process_mode = Node.PROCESS_MODE_INHERIT
			door.visible = true
