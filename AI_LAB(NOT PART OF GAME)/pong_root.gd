extends root

@export var Ball: CharacterBody2D
@export var player_paddle: CharacterBody2D
@export var enemy_paddle: CharacterBody2D


const INITIAL_BALL_SPEED = 200

var ball_speed = INITIAL_BALL_SPEED

const PAD_SPEED = 150
var direction = Vector2(1.0, 0.0)
var ball_pos

@onready var initial_pos = Vector2(571,372)

var player_score: int
var enemy_score: int



func _on_ball_range_body_entered(body: Node2D) -> void:
	if body.name == "Ball":
		blackboard.set("ball", body)
		blackboard.set("in_range", true)


func _on_ball_range_body_exited(body: Node2D) -> void:
	if body.name == "Ball":
		blackboard.set("ball", null)
		blackboard.set("in_range", false)
	
	

func _process(delta: float) -> void:
	Ball.position += direction * ball_speed * delta

func _on_right_area_body_entered(body: Node2D) -> void:
	if body.name == "Ball":
		blackboard.set("ball_scored", true)
		blackboard.set("ball", body)
		blackboard.set("scorer_name", "player")
		

func _on_left_area_body_entered(body: Node2D) -> void:
	if body.name == "Ball":
		blackboard.set("ball_scored", true)
		blackboard.set("ball", body)
		blackboard.set("scorer_name", "enemy")

func _on_top_area_body_entered(body: Node2D) -> void:
	if body.name == "Ball":
		direction.y = -direction.y


func _on_bottom_area_body_entered(body: Node2D) -> void:
	if body.name == "Ball":
		direction.y = -direction.y

func _on_player_area_body_entered(body: Node2D) -> void:
	if body.name == "Ball":
		print("BALL IN MY COURT!")
		direction.x = -direction.x
		direction.y = randf() *2.0 -1
		direction = direction.normalized()
		ball_speed *= 1.1
