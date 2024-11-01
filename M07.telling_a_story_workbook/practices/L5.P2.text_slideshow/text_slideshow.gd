extends ColorRect

var items: Array[String] = [
	"Strings. Ints. Floats. Nulls.",
	"Long ago, the four types lived together in harmony.",
	"Then, everything changed when the typed Array arrived.",
	"Only the Programmer, student of all types, could stop them.",
	"But when the world needed them most, they were studying on GDQuest.",
]
var item_index := 0

@onready var rich_text_label: RichTextLabel = %RichTextLabel
@onready var button: Button = %Button


func _ready() -> void:
	button.pressed.connect(advance)
	show_text()


func show_text() -> void:
	var current_item := items[item_index]
	rich_text_label.text = current_item
# Increments the index each time is called.
func advance() -> void:
	item_index += 1
	if item_index >= items.size():
		item_index = 0
	show_text()
