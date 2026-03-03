extends Node

@export var anim_player : AnimationPlayer

func _ready() -> void:
	SigBus.connect("STUNNED", play_anim)
	
	
func play_anim():
	anim_player.play("DECAL ANIM")
	
