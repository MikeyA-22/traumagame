extends Condition

class_name BallInteraction

@export var stop_dist = 2
var ball_hit
func tick(actor, delta, blackboard):
	ball_hit = blackboard.get("ball_hit")
	if ball_hit == true:
		return STATUS.SUCCESS
	else:
		return STATUS.FAIL
	
func _on_enemy_area_body_entered(body: Node2D) -> void:
	if body.name == "Ball":
		blackboard.set("ball_hit",true)
		
func _on_player_area_body_entered(body: Node2D) -> void:
	if body.name == "Ball":
		print("BALL IN PLAYER AREA")
		blackboard.set("ball_hit",true)
		print(blackboard.get("ball_hit"))
