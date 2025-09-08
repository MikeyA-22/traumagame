extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func configure_blending_times():
	set_blend_time("walk", "jump", 0.7)
	set_blend_time("landing", "walk", 0.4)
	set_blend_time("jump","in_air",0.3)
	set_blend_time("in_air", "landing", 0.6)
	set_blend_time("landing", "idle", 0.9)
	set_blend_time("hit_1","hit_2", 0.7)
	set_blend_time("idle","hit_1", 0.4)
	set_blend_time("hit_1","idle", 0.6)
	set_blend_time("hit_2","idle", 0.5)
