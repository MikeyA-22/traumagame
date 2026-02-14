extends root

var in_range = false

func _on_ball_range_body_entered(body: Node2D) -> void:
	print("Something...")
	if body.name == "Ball":
		print("IN RANGE!")
		in_range = true
		blackboard.set("in_range", in_range)
		blackboard.set("ball_pos", body.position)


func _on_ball_range_body_exited(body: Node2D) -> void:
	if body.name == "Ball":
		print("NOT IN RANGE!")
		in_range = false
		blackboard.set("in_range", in_range)
