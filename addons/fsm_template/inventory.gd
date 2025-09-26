extends Node

class_name Inventory

@onready var model = $".."
@onready var items = []
@onready var right_hand = $"../RightHand"
@onready var active_item: Pickable


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("tab"):
		switch_item()


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

func switch_item():
	if !items.is_empty():
		print(items)
		var itemdata: ItemData = load("res://Resource/%s.tres" % active_item.item_name)
		items.append(itemdata)
		active_item.free()
		active_item = items.front()._load_item()
		items.pop_front()
		right_hand.add_child(active_item)
		set_active_item(active_item)
	else:
		print(items)
		print("no items in item list")
		

func set_active_item(item: Pickable):
	Game_Global.active_object = item
	model.active_object = item
	active_item = item
	#object.basis = right_hand.basis
	item.reparent(right_hand)
	item.transform = right_hand.transform
	item.position = Vector3.ZERO
