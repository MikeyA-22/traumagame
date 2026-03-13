extends Action

var roar_sound = preload("res://Music/monster/monster attack.MP3")
var done = false
@onready var scream_player = $"../../../../../ScreamPlayer"

@export var animation : String

func tick(actor : Enemy, delta, blackboard: Dictionary):
	if Game_Global.hidden:
		return STATUS.FAIL
	if not scream_player.playing:
		scream_player.play()
		actor.animation_player.play(animation)
	
	if scream_player.playing:
		return STATUS.RUNNING
	
	return STATUS.SUCCESS
