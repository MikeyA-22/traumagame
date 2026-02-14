extends Action

@export var ball: CharacterBody2D
@export var speed: float

func tick(actor, delta, blackboard):
	#print("GOING TO LOCATION")
	var ball_pos = ball.position
	actor.move_towards(ball_pos,speed,delta)
	return STATUS.SUCCESS
