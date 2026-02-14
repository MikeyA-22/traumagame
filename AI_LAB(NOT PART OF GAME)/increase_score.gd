extends Action



@export var score: int
@export var label: Label

func tick(actor, delta, blackboard):
		var ball:CharacterBody2D = blackboard.get("ball")
		score += 1
		label.text = str(score)
		blackboard.set("scorer_name", null)
		return STATUS.SUCCESS
		
