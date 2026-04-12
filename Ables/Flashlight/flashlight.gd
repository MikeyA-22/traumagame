extends Pickable

class_name Flashlight
#@onready var light: SpotLight3D = $SpotLight3D
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	item_data = load("res://Resource/Flashlight.tres")
	messages = ["[color=black]A [color=red]FLASHLIGHT!!![/color]",
									"[color=red] I can press [color=purple] LEFT CLICK[/color] to use it. [/color]",
									"[color=red]THERE SHOULD BE SOME SPARE [color=purple] BATTERIES[/color] on the kitchen counter[/color]",
									"[color=red] GO FIND THE BIRTHDAY CARD[/color]"]
	
	pickable_action = {
		"light_attack_pressed" : "Flashlight"
	}
	#if "ON" in item_data.item_info:
		#item_data.item_info = "ON"
	#else:
		#item_data.item_info = "OFF"
	

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
