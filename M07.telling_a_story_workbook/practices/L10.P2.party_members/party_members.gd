extends ColorRect

@onready var texture_rect: TextureRect = %TextureRect
@onready var rich_text_label: RichTextLabel = %RichTextLabel
@onready var button_next: Button = %ButtonNext
@onready var button_previous: Button = %ButtonPrevious

var items: Array[Dictionary] = [
	{
		"name": "Dani", 
		"portrait": preload("./assets/character_dani.png")
	},
	{
		"name": "Gobot", 
		"portrait": preload("./assets/character_gdbot.png")
	},
	{
		"name": "Nova", 
		"portrait": preload("./assets/character_nova.png")
	},
]
var item_index := 0

func _ready() -> void:
	button_next.pressed.connect(advance)
	button_previous.pressed.connect(rewind)
	show_party_member()

func show_party_member() -> void:
	texture_rect.texture = items[item_index].portrait 
	rich_text_label.text = items[item_index].name

func advance() -> void:
	item_index += 1
	if item_index >= items.size():
		item_index = 0
	show_party_member()

func rewind() -> void:
	item_index -= 1
	if item_index < 0:
		item_index = items.size() - 1
	show_party_member()
