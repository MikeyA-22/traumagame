extends Node
class_name InputInternal

var mouse = false

#@onready var InteractionCatcher = $"../visuals/Cube_022/LocalCamera/Camera3D/InteractionCatcher"

func gather_input() -> InputPackage:
	var new_input = InputPackage.new() 
	
	if Input.is_key_pressed(KEY_ESCAPE):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	new_input.input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if new_input.input_direction != Vector2.ZERO:
		new_input.actions.append("run")
	
	
	if Input.is_action_just_pressed("ui_accept"):
		if new_input.actions.has("run"):
			pass#new_input.actions.append("jump_start")
	
	if Input.is_action_just_pressed("onegbosa"):
		new_input.interactions.append("light_attack_pressed")
		#print("ONE GBOSA! GIDEM!!!")
	
	if Input.is_action_just_pressed("interact"):
		new_input.actions.append("Interacting")
	
	if new_input.actions.is_empty():
		new_input.actions.append("idle")
	
	return new_input
