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
	#if(nav_agent.get_current_navigation_path()):
		##print(nav_agent.get_current_navigation_path())
		#character.velocity = character.global_position.direction_to(grounded_player_pos) * character.speed
		#character.look_at(grounded_player_pos)
		#character.move_and_slide()
	#else:
	#print("using nav mesh")
	# Update target only when player moves enough
	if nav_agent.target_position.distance_to(player.global_position) > 0.2:
		nav_agent.set_target_position(player.global_position)

	if nav_agent.is_navigation_finished():
		character.velocity = Vector3.ZERO
		return

	var next_pos = nav_agent.get_next_path_position()
	var delt = next_pos - character.global_position

	
	if delt.length() < 0.05:
		character.velocity = Vector3.ZERO
		return

	var direction = delt.normalized()
	character.velocity = direction * character.speed

	
	character.look_at(character.global_position + direction)

	character.move_and_slide()

func on_enter():
	fstep1.play()
	
func on_exit():
	fstep1.stop()
