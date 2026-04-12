extends Photo


func _ready() -> void:
	messages = ["[color=red]Is this ...{p-0.5}[/color]","[color=green] ME??...[/color]","[color=red]It...{p=0.5} it can't be... [/color]"]
	sfx = preload("res://Music/sfx/pick up paper.MP3")
