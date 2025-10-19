extends AudioStreamPlayer

func _process(delta: float) -> void:
	if Game_Global.current_gState == Game_Global.game_state.STATE_ENEMY_ATTACK:
		print("working")
		play()
