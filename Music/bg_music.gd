extends AudioStreamPlayer

@export var alter: AudioStreamMP3
@export var main: AudioStreamMP3
var last_state = null

func _process(delta: float) -> void:
	var state = Game_Global.current_gState
	if state != last_state:
		last_state = state
		if state != Game_Global.game_state.STATE_1:
			stream = alter
			play() # restart playback with the new stream
		else:
			stream = main
			play()	
