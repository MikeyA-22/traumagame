extends AIstate




func check_transition(delta) -> Array:
	if Game_Global.hidden:
		return[true,"idle"]
	elif player.global_position.distance_to(character.global_position) > character.deaggro_radius and !Game_Global.hidden:
		return [true, "pursuit"]
	elif player.global_position.distance_to(character.global_position) < character.attack_radius and !Game_Global.hidden:
		return [true, "idle"]
	return [false, ""]


func update(delta):
	#RenderingServer.global_shader_parameter_set("static_noise_intensity",static_noise)
	var grounded_player_pos = player.global_position
	grounded_player_pos.y = character.global_position.y
	#static_noise = (character.global_position.y - player.global_position.y) * -1 * stat_adjuster
	#print(static_noise)
	
	character.velocity = character.global_position.direction_to(grounded_player_pos) * character.speed * 0.5
	character.look_at(grounded_player_pos)
	character.move_and_slide()

func on_enter():
	fstep2.play()
	
func on_exit():
	fstep2.stop()
