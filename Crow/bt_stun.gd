extends Action

@export var animation: String

@export_group("Bboard names")
@export var monster_id: String
@export var player_id: String

func tick(actor, delta, blackboard: Dictionary):
	actor.anim_player1.play(animation)
	var monster = blackboard.get(monster_id)
	var player = actor.player
	RenderingServer.global_shader_parameter_set("heat_strength", Game_Global.madness_increment)
	Game_Global.madness_increment += .0075
	player.resources.sanity -= 10
	monster.statemachine.switch_to("stunned")
	return STATUS.SUCCESS
	
