extends Action

@export var player: CharacterBody2D
const SPEED = 300.0

func tick(actor, delta, blackboard):
	var direction := Input.get_axis("ui_up", "ui_down")
	player.velocity.y = direction * SPEED
	player.move_and_slide()
	return STATUS.SUCCESS
