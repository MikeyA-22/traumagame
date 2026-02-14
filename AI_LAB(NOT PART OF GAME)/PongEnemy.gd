extends CharacterBody2D

@export var label: Label

func move_towards(target, speed, delta):
	var dir = global_position.direction_to(target)
	
	velocity.y = speed * dir.y
	velocity.x = 0
	move_and_slide()
