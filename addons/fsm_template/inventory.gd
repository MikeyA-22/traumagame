extends Node

class_name Inventory

@onready var model = $".."
@onready var items = []
@onready var right_hand = $"../RightHand/Right"
@onready var left_hand = $"../LeftHand/Left"
@onready var active_item: Pickable
@onready var inventory_display = $InventoryDisplay



func _ready() -> void:
	pass
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("tab"):
		switch_item()


func add(item: Pickable, use_message: bool):
	if use_message:
		SigBus.PICKING_UP.emit(item.messages, item.time)
	if right_hand.get_children().is_empty() and left_hand.get_children().is_empty():
		set_active_item(item)
		print("Setting active item", item)
	else:
		var itemdata: ItemData = load("res://Resource/%s.tres" % item.item_name)
		items.append(itemdata)
		item.free()
	if Game_Global.save_game != null:
		Game_Global.save_game.inventory_items = items
		#object.free()
		#print("objects array has: ", items)
		#print("inventory node has: ",items)
		#print("active_weapon has: ",right_hand.get_children())



func switch_item():
	if !items.is_empty():
		#print(items)
		var item_data: ItemData = load("res://Resource/%s.tres" % active_item.item_name)
		items.append(item_data)
		if active_item.item_name != "Flashlight": active_item.free()
		active_item = items.front()._load_item()
		items.pop_front()
		assign_item(active_item)
		inventory_display.display(item_data)
		set_active_item(active_item)
	#else:
		#pass#print(items)
		#print("no items in item list")
		

func set_active_item(item: Pickable):
	item.on_picked()
	Game_Global.active_object = item
	model.active_object = item
	active_item = item
	inventory_display.active_item_data = item.item_data
	var item_data = inventory_display.active_item_data
	inventory_display.display(item_data)
	if Game_Global.save_game != null:
		Game_Global.save_game.active_item = item_data
	print(item_data.item_name)
	#object.basis = right_hand.basis
	put_item_in_hand(item)

func remove_item_data(item_data: ItemData):
	items.erase(item_data)
	
func assign_item(active_item):
	if active_item.name == "Flashlight":
		left_hand.add_child(active_item)
	else:
		right_hand.add_child(active_item)

func put_item_in_hand(item : Pickable):
	if item.item_data.item_name != "Flashlight":
		item.reparent(right_hand)
		item.transform = right_hand.transform
	else:
		print("PUTTING IN LEFT HAND!!!")
		item.reparent(left_hand)
		item.transform = left_hand.transform
	item.position = Vector3.ZERO
	item.remove_outline()
	item.remove_indication()
	item.set_collision_layer_value(2,false)
	item.set_collision_layer_value(9,true)
