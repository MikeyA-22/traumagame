extends Condition

@export var animation: String

var hittable := false
var animation_started := false
var animation_done := false

func tick(actor, delta, blackboard: Dictionary):
	if not animation_started:
		print("STUN TIME!!!")
		RenderingServer.global_shader_parameter_set(
			"heat_strength",
			Game_Global.madness_increment
		)
		Game_Global.madness_increment += .00005 * delta

		actor.anim_player1.play(animation)
		actor.anim_player2.play(animation)

		# Listen once
		actor.anim_player2.animation_finished.connect(_on_anim_finished, CONNECT_ONE_SHOT)

		animation_started = true
		return STATUS.RUNNING

	# Wait until animation finishes
	if not animation_done:
		return STATUS.RUNNING

	# Animation finished → now check logic
	if Input.is_action_just_pressed("onegbosa") and hittable:
		_reset()
		return STATUS.SUCCESS

	_reset()
	return STATUS.FAIL


func _on_anim_finished(anim_name):
	if anim_name == animation:
		print("done animating.")
		animation_done = true


func _reset():
	animation_started = false
	animation_done = false


func _on_hitbox_body_entered(body: Node3D) -> void:
	hittable = true


func _on_hitbox_body_exited(body: Node3D) -> void:
	hittable = false
