extends Action

const INITIAL_BALL_SPEED = 200

@export var our_root: root
@export var direction: Vector2

func tick(actor, delta, blackboard):
	our_root.ball_speed = INITIAL_BALL_SPEED
	our_root.direction = direction
	our_root.Ball.position = our_root.initial_pos
	return STATUS.SUCCESS
