extends Pickable

class_name Batteries

func _ready() -> void:
	item_data = load("res://Resource/Batteries.tres")
	messages = ["[color=red] USE [color=green]TAB[/color] TO SWITCH ITEMS[/color]","[color=red]BATTERIES, PRESS [color=green]Z[/color] USE THEM FOR YOUR FLASHLIGHT![/color]"]
	
	pickable_action = {
		"light_attack_pressed" : "Batteries"
	}
