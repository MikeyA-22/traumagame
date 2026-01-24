extends CharacterBody3D

class_name LabEnemy
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@export var speed_factorer = 0.5
@export var boredom = 0
var bdom_mult = 0.2

func _physics_process(delta: float) -> void:
	if boredom >= 8:
		boredom += delta * bdom_mult
	
		
		
func move_towards(target):
	var dir = global_position.direction_to(target.position)
	
	velocity = dir * SPEED * speed_factorer
	move_and_slide()
