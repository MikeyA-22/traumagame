extends AIstate




func check_transition(delta) -> Array:
	if player.global_position.distance_to(character.global_position) > character.deaggro_radius:
		return [true, "pursuit"]
	if player.global_position.distance_to(character.global_position) < character.attack_radius:
		return [true, "idle"]
	return [false, ""]


func update(delta):
	RenderingServer.global_shader_parameter_set("static_noise_intensity",static_noise)
	var grounded_player_pos = player.global_position
	grounded_player_pos.y = character.global_position.y
	static_noise = (player.global_position.y - character.global_position.y) * stat_adjuster * 100
	print(static_noise)
	
	character.velocity = character.global_position.direction_to(grounded_player_pos) * character.speed * 0.5
	character.look_at(grounded_player_pos)
	character.move_and_slide()
