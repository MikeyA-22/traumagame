extends Pickable

class_name Pills



func _ready() -> void:
	messages = ["[color=red]Use [color=green]TAB[/color] to scroll through inventory
	and [color=green]Z/Left click[/color]to switch[/color]"]
	
	
	pickable_action = {
	"light_attack_pressed":"take_pills"
	}
