extends CharacterBody3D

##CROW SCRIPT
#declaring our variables
var monster : Enemy
@onready var my_root = $".."
@onready var self_crow = $"."
@export var return_speed : float = 9

@export var aggro_radius : float = 8
@export var attack_radius : float = 2
@export var deaggro_radius : float = 10
@export var anim_player1: AnimationPlayer
@export var anim_player2: AnimationPlayer


var spawn_point : Vector3
var player: Player




func _ready():
	spawn_point = global_position
	player = my_root.player
	

func _process(delta):
	pass
