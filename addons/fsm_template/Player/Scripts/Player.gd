
extends CharacterBody3D

class_name Player

@onready var inputgatherer = $InputGatherer

@onready var Model = $Model
@onready var inventory = $Model/Inventory
@onready var photobook = $Model/Photobook
@onready var camera_mount = $LocalCamera
@onready var visuals = $visuals as PlayerVisuals


@onready var interaction_catcher = $LocalCamera/Camera3D/InteractionCatcher

@export var monster: Enemy
@export var resources: PlayerResources

@export var crow : Crow

@export var inventory_list : Array[ItemData]
@export var active_item : ItemData
@export var photos: Array[PhotoData]
var hidden = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var dampener = 0.1

func _ready() -> void:
	visuals.accept_skeleton(Model.skeleton)
	set_items()
	
	#Model.anim_tree.set("parameters/conditions/idle", true)
	#Model.animator.play("idle")

func _physics_process(delta: float) -> void:
	var input = inputgatherer.gather_input()
	
	
	Model.update(input, delta)
	Model.hidden = hidden
	
	if not is_on_floor():
		velocity.y -= gravity * delta * dampener
		move_and_slide()
	
	input.queue_free()
	#Visuals -> follow parent transformation
	

func set_items():
	inventory.items = Game_Global.save_game.inventory_items
	active_item = Game_Global.save_game.active_item
	photos = Game_Global.save_game.photos
	Game_Global.save_game.level = get_tree().current_scene.scene_file_path
	photobook.photo_datas = photos
	photobook.set_photos()
	
	
	if active_item != null:
		inventory.active_item = Game_Global.save_game.active_item.item_model.instantiate()
	inventory.switch_item()
