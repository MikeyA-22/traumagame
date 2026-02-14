extends Action

class_name ReflectBall

@export var our_root: root
@export var particles: GPUParticles2D

func tick(actor, delta, blackboard):
		print("REFLECT BALL")
		our_root.direction.x = -our_root.direction.x
		our_root.direction.y = randf() *2.0 -1
		our_root.direction = our_root.direction.normalized()
		our_root.ball_speed *= 1.1
		blackboard.set("ball_hit",false)
		particles.emitting = true
		return STATUS.SUCCESS
		
