extends AIstate


func check_transition(delta) -> Array:
	if player.global_position.distance_to(spawn_point) < character.aggro_radius and player.global_position.distance_to(character.position) > character.deaggro_radius:
		return[true,"pursuit"]
	return [false,""]
