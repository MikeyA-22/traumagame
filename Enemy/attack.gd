extends AIstate

class_name Attack

var roar_sound = preload("res://Music/monster/monster attack.MP3")
var done = false
@onready var scream_player = $"../../ScreamPlayer"
func check_transition(delta) -> Array:
	if Game_Global.hidden:
		return [true, "idle"]
	elif done == true:
		return [true, "idle"]
	elif player.global_position.distance_to(character.global_position) < character.attack_radius and !Game_Global.hidden:
		return [true, "idle"]
	return[false, ""]
	

func update(delta):
	if scream_player.playing == false:
		done = true

func on_enter():
	scream_player.stream = roar_sound
	scream_player.play()
	

func on_exit():
	pass
