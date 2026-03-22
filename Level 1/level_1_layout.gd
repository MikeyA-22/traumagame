extends Node3D

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





func _ready() -> void:
	next_label.visible = false
	#call_deferred("initial_message")
	SigBus.connect("PICKING_UP", on_object_picked)
	photo.connect("picked_up", Callable(self,"reveal_path"))
	reset_params()
	if Game_Global.save_game != null:
		Game_Global.save_game.level = current_level
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
	path_wall.queue_free()
