extends Node

class_name Inventory

@onready var model = $".."
@onready var items = []
@onready var right_hand = $"../RightHand"


func _ready() -> void:
	pass

func add(item: Pickable):
	if right_hand.get_children().is_empty():
		set_active_item(item)
	else:
		var itemdata: ItemData = load("res://Resource/%s.tres" % item.item_name)
		items.append(itemdata)
		item.free()
		#object.free()
		print("objects array has: ", items)
		print("inventory node has: ",items)
		print("active_weapon has: ",right_hand.get_children())

func remove():
	pass

func get_item(itemdata: ItemData):
	pass

func set_active_item(item: Pickable):
	Game_Global.active_object = item
	model.active_object = item
	#object.basis = right_hand.basis
	item.reparent(right_hand)
	item.transform = right_hand.transform
	item.position = Vector3.ZERO
