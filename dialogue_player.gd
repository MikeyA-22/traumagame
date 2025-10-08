class_name DialoguePlayer
extends AudioStreamPlayer

var random_num_gen = RandomNumberGenerator.new()


func _ready() -> void:
	random_num_gen.randomize()
	

func play_dialogue(from_position = 0.0) -> void:
	pitch_scale = random_num_gen.randf_range(0.95,1.08)
	play_dialogue(from_position)
