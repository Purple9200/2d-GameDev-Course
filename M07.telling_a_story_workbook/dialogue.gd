extends Control

var current_item_index := 0
var expressions := {
	"happy": preload("res://assets/emotion_happy.png"),
	"regular": preload("res://assets/emotion_regular.png"),
	"sad": preload("res://assets/emotion_sad.png"),
}

@onready var rich_text_label: RichTextLabel = %RichTextLabel
@onready var next_button: Button = %NextButton
@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer
@onready var body = %Body
@onready var expression = %Expression

var dialogue_items: Array[Dictionary] = [
	{
		"expression": expressions["sad"],
		"text": "I am super stressed about college applications"
	},
	{
		"expression": expressions["regular"],
		"text": "I know I should be happy"
	},
	{
		"expression": expressions["regular"],
		"text": "Since I'm done with 3 PIQs"
	},
	{
		"expression": expressions["sad"],
		"text": "But I still have 1 more left which I have no clue what to write"
	},
]
func _ready() -> void:
	show_text()
	next_button.pressed.connect(advance)

func show_text() -> void:
	var current_item := dialogue_items[current_item_index]
	rich_text_label.text = current_item["text"]
	expression.texture = current_item["expression"]
	rich_text_label.visible_ratio = 0.0
	var tween := create_tween()
	var text_appearing_duration := 1.2
	tween.tween_property(rich_text_label, "visible_ratio", 1.0, text_appearing_duration)
	var sound_max_length := audio_stream_player.stream.get_length() - text_appearing_duration
	var sound_start_position := randf() * sound_max_length
	audio_stream_player.play(sound_start_position)
	tween.finished.connect(audio_stream_player.stop)
func advance() -> void:
	current_item_index += 1
	if current_item_index == dialogue_items.size():
		get_tree().quit()
	else:
		show_text()
