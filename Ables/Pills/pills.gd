extends Pickable

class_name Pills



func _ready() -> void:
	item_data = load("res://Resource/pills.tres")
	
	messages = ["[color=red]Use [color=green]TAB[/color] to scroll through inventory
	and [color=green]Z/Left click[/color]to switch[/color]"]
	
	
	pickable_action = {
	"light_attack_pressed":"take_pills"
	}
	if item_data == null:
		print("Pills has no item_data assigned in Inspector!")
	item_data.item_info = Game_Global.pills_amount
	#print("the data is: ",item_data)
	#print("item name is: ",item_data.item_name)
	#item_data.item_info = 5

func _process(delta: float) -> void:
	item_data.item_info = Game_Global.pills_amount
