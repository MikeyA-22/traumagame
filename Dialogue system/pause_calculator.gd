extends Node
class_name PauseCalculator

var pauses = []
const PAUSE_PATTERN = "({p=\\d([.]\\d+)?[}])"
var pause_regex = RegEx.new()

signal pause_requested(duration)


func _ready() -> void:
	pause_regex.compile(PAUSE_PATTERN)
	
func extract_pauses_from_string(source_string : String)-> String:
	pauses = []
	find_pauses(source_string)
	return extract_tags(source_string)
	

func find_pauses(from_string: String) -> void:
	var found_pauses = pause_regex.search_all(from_string)
	for result in found_pauses:
		var tag_string = result.get_string() as String
		var tag_position = _adjust_position(result.get_start(),from_string)
		
		var pause = Pause.new(tag_position, tag_string)
		pauses.append(pause)
		

	
func extract_tags(from_string: String) -> String:
	var custom_regex = RegEx.new()
	custom_regex.compile("({(.*?)})")
	return custom_regex.sub(from_string,"", true)
	
func check_at_position(pos):
	for pause in pauses:
		if pause.pause_pos == pos:
			#print_debug(pos)
			emit_signal("pause_requested", pause.duration)
			
func _adjust_position(pos: int, source_string: String) -> int:
	
	# Previous tags
	var custom_tag_regex := RegEx.new()
	custom_tag_regex.compile("({(.*?)})")
	
	var new_pos := pos
	var left_of_pos := source_string.left(pos)
	var all_prev_tags := custom_tag_regex.search_all(left_of_pos)
	for tag_result in all_prev_tags:
		new_pos -= tag_result.get_string().length()
	
	var bbcode_i_regex := RegEx.new()
	var bbcode_e_regex := RegEx.new()
	
	# Previous bbcodes
	bbcode_i_regex.compile("\\[(?!\\/)(.*?)\\]")
	bbcode_e_regex.compile("\\[\\/(.*?)\\]")
	
	var all_prev_start_bbcodes := bbcode_i_regex.search_all(left_of_pos)
	for tag_result in all_prev_start_bbcodes:
		new_pos -= tag_result.get_string().length()
	
	var all_prev_end_bbcodes := bbcode_e_regex.search_all(left_of_pos)
	for tag_result in all_prev_end_bbcodes:
		new_pos -= tag_result.get_string().length()
	
	return new_pos
