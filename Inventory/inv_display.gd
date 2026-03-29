extends Node

class_name InventoryDisplay


@onready var inventory: Inventory = $".."
@onready var item_name: RichTextLabel = $VBoxContainer/ItemName
@onready var item_info_image: TextureRect = $VBoxContainer/ItemInfoImage
@onready var next_image : TextureRect = $VBoxContainer/ItemImage/NextImage
@onready var item_image: TextureRect = $VBoxContainer/ItemImage
@onready var items = []
##SERVES AS OUR DATA SOURCE FOR ACTIVE ITEMS(IF ANY)
@onready var active_item_data: ItemData
@onready var displayAnim: AnimationPlayer = $Displayanim
@onready var label : Label = $VBoxContainer/Label
func _ready() -> void:
	pass

func display(item_data: ItemData):
	##clear image
	item_info_image.texture = null
	if label.visible == false:
		label.visible = true
	##check if item has information, then display if so
	if item_data.item_info != null:
		display_info(item_data.item_info)
	## Animate and display the inventory items
	displayAnim.play("display")
	item_name.text = item_data.item_name
	item_image.texture = item_data.item_photo
	display_next()

func display_info(item_info_entry):
	item_info_image.texture = item_info_entry
	
	#print(item_info.text)

func display_next():
	items = inventory.items
	print("INVENTORY ITEMS ARE: ", items)
	if items.is_empty() == false:
		print("displaying: ", items.front(), "the items in inventory are currently: ", items)
		var next_item : ItemData = items.front()
		next_image.texture = next_item.item_photo
	
	
