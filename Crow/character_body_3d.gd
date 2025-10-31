extends CharacterBody3D

##CROW SCRIPT
#declaring our variables
var monster : Enemy
@onready var self_crow = $"."
@export var return_speed : float = 9

@export var aggro_radius : float = 8
@export var attack_radius : float = 2
@export var deaggro_radius : float = 10

var spawn_point : Vector3
@onready var pinpoint: PinJoint3D



func _ready():
	spawn_point = global_position

func _process(delta):
	pass#circular_motion()
