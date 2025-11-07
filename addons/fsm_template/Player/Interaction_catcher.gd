extends RayCast3D


var reticlenumber: float = 0
@onready var root_player = $"../../../../.."

func _process(delta: float) -> void:
	RenderingServer.global_shader_parameter_set("ReticleLerper",reticlenumber)
	if is_colliding():# == true and collision_mask == 2:
		var collider = get_collider()
		#print(collider.get_class())
		if collider.is_in_group("Doors") and Game_Global.active_object is Key:
			reticlenumber = 1
			
			Game_Global.current_interactor = collider
		elif collider is Pickable:
			reticlenumber = 1
			#print(collider)
			Game_Global.is_pickable = true
			Game_Global.current_pickable = collider
		else:
			#print(Game_Global.current_interactor)
			if collider is candle:
				Game_Global.current_interactor = collider
				reticlenumber = 1
				if Input.is_action_just_pressed("interact"):
					SigBus.BLOWN.emit(true)
			elif collider is HidingSpot:
				Game_Global.current_interactor = collider
				reticlenumber = 1
				if Input.is_action_just_pressed("interact"):
					SigBus.HIDE.emit(true, root_player, self)
			
	else :
		Game_Global.is_pickable = false
		reticlenumber = 0
