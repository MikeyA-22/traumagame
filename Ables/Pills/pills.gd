extends Pickable

class_name Pills



func _ready() -> void:
	messages = ["[color=red]These pills{p=0.5} can help me get my sanity back![/color]","[color=red] I can use [color=green]TAB[/color] to switch to them [/color]","[color=red] then I to press [color=green]Leftclick[/color] to use them[/color]"]
	
	pickable_action = {
	"light_attack_pressed":"take_pills"
	}
