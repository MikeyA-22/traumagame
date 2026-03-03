class_name FloorArea
extends Area3D

var player

@export var player_wood_sound: AudioStreamMP3

func _physics_process(delta: float) -> void:
	if player != null:
		if player.Model.current_state.name == "Run":
			print("Moving on me")

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		player = body
		print("player on me")
		print(body.Model.current_state)
			
