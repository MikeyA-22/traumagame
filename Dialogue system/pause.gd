extends Node
class_name Pause


const FLOAT_PATTERN = "\\d+\\.\\d+"
var pause_pos : int
var duration : float

func _init(position: int, tag_string: String) -> void:
	var duration_regex = RegEx.new()
	duration_regex.compile(FLOAT_PATTERN)
	
	duration = float(duration_regex.search(tag_string).get_string())
	pause_pos = int(clamp(position - 1,0,abs(position)))
