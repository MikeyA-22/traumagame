extends Node

class_name InventoryDisplay

##SERVES AS OUR DATA SOURCE FOR ACTIVE ITEMS(IF ANY)
@onready var inventory: Inventory = $".."
@onready var text: RichTextLabel = $VBoxContainer/text
@onready var image: TextureRect = $VBoxContainer/image
@onready var items = []
@onready var active_item_data: ItemData
@onready var displayAnim: AnimationPlayer = $Displayanim
func _ready() -> void:
	pass

func display(item_data: ItemData):
	displayAnim.play("display")
	text.text = active_item_data.item_name
	image.texture= active_item_data.item_photo
