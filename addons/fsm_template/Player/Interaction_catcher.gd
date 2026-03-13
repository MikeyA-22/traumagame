extends RayCast3D


var reticlenumber: float = 0
var reticlenumber2: float  = 0
@onready var root_player = $"../../.."
var sig
var sig_value
var interactable = false
var collider_map = {
	
}
func _process(delta:float) -> void:
	RenderingServer.global_shader_parameter_set("ReticleLerper",reticlenumber)
	RenderingServer.global_shader_parameter_set("ReticleLerper2",reticlenumber2)
	## If it is interacting with something, then it is one of two things, an interactable, or a pickable
	
	if is_colliding():
		var collider = get_collider()
		
		if collider is Pickable:
			assess_pickable(collider)
			
		else:
			assess_interactable(collider)
			if Input.is_action_just_pressed("interact") and interactable:
				
				print("SIG VALUE IS:", sig_value)
				sig.emit(sig_value)
				if Game_Global.active_tut_index == 2:
					Game_Global.progress_tutorial()
	
	else:
		Game_Global.is_pickable = false
		reticlenumber = 0
		reticlenumber2 = 0
		if Game_Global.current_interactor != null:
			Game_Global.current_interactor.hide_indication()
		if Game_Global.current_pickable != null:
			Game_Global.current_pickable.hide_indication()

		#print(collider.get_class())
	
	#if collider.is_in_group("Doors") and Game_Global.active_object is Key:
		#reticlenumber = 1
			
		#Game_Global.current_interactor = collider
	#elif collider is Pickable:
		#reticlenumber = 1
		##print(collider)
		
		#Game_Global.current_pickable = collider
	#else:
		##print(Game_Global.current_interactor)
		#if collider is candle:
			#assess_interactable(collider)
			#
		#elif collider is HidingSpot:
				#Game_Global.current_interactor = collider
				#assess_interactable(collider)
				#
				#if Input.is_action_just_pressed("interact"):
					#SigBus.HIDE.emit(root_player)
			#
	#
		
func assess_pickable(collider: Pickable):
	reticlenumber = 1
	Game_Global.is_pickable = true
	Game_Global.current_pickable = collider
	Game_Global.current_pickable.show_indication()
	
	
	#print("ASSESSING PICKABLE")

func assess_interactable(collider):
	#print("ASSESSING INTERACTABLE")
	interactable = false
	reticlenumber = 0

	var data = collider.get_interaction_data(root_player)

	if not data.get("interactable", false):
		print("interactable data false!")
		return

	interactable = true
	reticlenumber = data.get("reticle", 0)
	reticlenumber2 = data.get("reticle2", 0)
	sig = data.sig
	sig_value = data.sig_value
	

	Game_Global.current_interactor = collider
	Game_Global.current_interactor.show_indication()
