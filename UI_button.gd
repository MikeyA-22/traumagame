extends TextureButton

class_name UIbutton

#func _ready() -> void:
	#connect("mouse_entered", Callable(self, "on_mouse_entered"))
	#connect("mouse_exited",Callable(self,"on_mouse_exited"))
	#
#
#func on_mouse_entered():
	#print("entered", self)
	#var tween = create_tween()
	#tween.tween_property(self,"self_modulate:a",0.0,1.0)
	#print(self_modulate.a)
	#
	#
#func on_mouse_exited():
	#print("exited", self)
	#var tween = create_tween()
	#tween.tween_property(self,"self_modulate:a",1.0,0.0)
	#self_modulate.a = 0
