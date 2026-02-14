extends Node2D


@export var Ball: CharacterBody2D
@export var player_paddle: CharacterBody2D
@export var enemy_paddle: CharacterBody2D


const INITIAL_BALL_SPEED = 200

var ball_speed = INITIAL_BALL_SPEED

const PAD_SPEED = 150
var direction = Vector2(1.0, 0.0)
var ball_pos

var initial_pos

var player_score: int
var enemy_score: int

func _ready() -> void:
	print("Game start")
	initial_pos = Ball.position
	
	

func _process(delta: float) -> void:
	pass#Ball.position += direction * ball_speed * delta
	










#func _on_left_area_body_entered(body: Node2D) -> void:
	#if body.name == "Ball":
		#Ball.position = initial_pos
		#ball_speed = INITIAL_BALL_SPEED
		#enemy_score += 1
		#enemy_paddle.label.text = str(enemy_score)
		#direction = Vector2(-1, 0)
#
#
#func _on_right_area_body_entered(body: Node2D) -> void:
	#if body.name == "Ball":
		#Ball.position = initial_pos
		#ball_speed = INITIAL_BALL_SPEED
		#player_score += 1
		#player_paddle.label.text = str(player_score)
		#direction = Vector2(1, 0)
