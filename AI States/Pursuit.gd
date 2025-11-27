extends AIstate




func check_transition(delta) -> Array:
	if Game_Global.hidden:
		return [true, "idle"]
	elif player.global_position.distance_to(character.global_position) < character.deaggro_radius:
		return [true, "creep"]
	return [false, ""]


func update(delta):
	var grounded_player_pos = player.global_position
	grounded_player_pos.y = character.global_position.y
	
	#static_noise = (character.global_position.y - player.global_position.y) * -1 * stat_adjuster
	#print(static_noise)
	character.velocity = character.global_position.direction_to(grounded_player_pos) * character.speed
	character.look_at(grounded_player_pos)
	character.move_and_slide()

func on_enter():
	fstep1.play()
	
func on_exit():
	fstep1.stop()
