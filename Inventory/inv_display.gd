extends Node

class_name InventoryDisplay


@onready var inventory: Inventory = $".."
@onready var item_name: RichTextLabel = $VBoxContainer/HBoxContainer/ItemName
@onready var item_info: RichTextLabel = $VBoxContainer/HBoxContainer/ItemInfo
@onready var item_image: TextureRect = $VBoxContainer/ItemImage
@onready var items = []
##SERVES AS OUR DATA SOURCE FOR ACTIVE ITEMS(IF ANY)
@onready var active_item_data: ItemData
@onready var displayAnim: AnimationPlayer = $Displayanim
func _ready() -> void:
	pass

func display(item_data: ItemData):
	##clear text
	item_info.text = ""
	##check if item has information, then display if so
	if item_data.item_info != null:
		display_info(str(item_data.item_info))
	## Animate and display the inventory items
	displayAnim.play("display")
	item_name.text = item_data.item_name
	item_image.texture = item_data.item_photo
	

func display_info(item_info_entry: String):
	item_info.text = str(item_info_entry)
	#print(item_info.text)
	
