extends AudioStreamPlayer

@export var alter: AudioStreamMP3
@export var main: AudioStreamMP3
@export var third_phase: AudioStreamMP3
@export var final_phase: AudioStreamMP3
var last_state = null

func _process(delta: float) -> void:
	var state = Game_Global.current_gState
	if Game_Global.madness_increment > 0.03 and Game_Global.madness_increment < 0.04:
		stream = third_phase
	if Game_Global.madness_increment > 0.04:
		stream = final_phase
	if state != last_state:
		last_state = state
		if state != Game_Global.game_state.STATE_1:
			stream = alter
			play() # restart playback with the new stream
		else:
			stream = main
			play()	
	
