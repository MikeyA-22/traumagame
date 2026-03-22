extends Node
class_name InputInternal

var mouse = false

#@onready var InteractionCatcher = $"../visuals/Cube_022/LocalCamera/Camera3D/InteractionCatcher"
@export var interaction_var : String
@export var interaction_bool: bool
@export var walk_var: String

var pressed = false
func gather_input() -> InputPackage:
	var new_input = InputPackage.new() 
	
	if Input.is_key_pressed(KEY_ESCAPE):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	new_input.input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if Game_Global.hidden == false:
		if new_input.input_direction != Vector2.ZERO:
			new_input.actions.append(walk_var)
			if Game_Global.active_tut_index == 0:
				Game_Global.progress_tutorial()

	
	
		if Input.is_action_just_pressed("ui_accept"):
			if new_input.actions.has("run"):
				pass#new_input.actions.append("jump_start")
	
		if Input.is_action_just_pressed("onegbosa"):
			new_input.interactions.append("light_attack_pressed")
		#print("ONE GBOSA! GIDEM!!!")
	
		if Input.is_action_just_pressed("interact"):
		#print_debug("interaction")
			new_input.interactions.append(interaction_var)# if interaction_bool else new_input.actions.append(interaction_var)
			
	
		if new_input.actions.is_empty():
			new_input.actions.append("idle")
	else:
		new_input.actions.append("hidden")
	
		
	return new_input
