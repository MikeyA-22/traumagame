extends Pickable

class_name Flashlight
#@onready var light: SpotLight3D = $SpotLight3D
# Called when the node enters the scene tree for the first time.


func _ready() -> void:
	messages = ["[color=black]A [color=red]FLASHLIGHT!!![/color]",
									"[color=red] I can press [color=green] LEFT CLICK[/color] to use it. [/color]",
									"[color=red] I should also[color=green] blow out those candles [/color]"]
	
	pickable_action = {
		"light_attack_pressed" : "Flashlight"
	}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#func _on_flashlight_flash(light: SpotLight3D) -> void:
	#if light.light_energy == 2:
		#light.light_energy = 0
		#print(light.light_energy)
	#else:
		#light.light_energy = 2
		#print(light.light_energy)
