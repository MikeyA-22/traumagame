extends root




func _physics_process(delta: float) -> void:
	if stop_tick == false:
		child.tick(delta)
		


		
func is_tick_done(done):
	stop_tick = done
