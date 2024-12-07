extends Control

var expressions := {
	"happy": preload("res://assets/emotion_happy.png"),
	"regular": preload("res://assets/emotion_regular.png"),
	"sad": preload("res://assets/emotion_sad.png"),
}
var bodies := {
	"sophia": preload ("res://assets/sophia.png"),
	"pink": preload ("res://assets/pink.png")
}

var dialogue_items: Array[Dictionary] = [
{
		"expression": expressions["regular"],
		"text": "[wave]Hey, wake up![/wave]\nLets go play tennis!",
		"character": bodies["sophia"],
		"choices": {
			"Nah, I'm good": 2,
			"Alright, sayless": 1,
		},
	},
	{
		"expression": expressions["happy"],
		"text": "We will play up to three [b]sets[/b].",
		"character": bodies["sophia"],
		"choices": {
			"Fine by me.": 3,
			"That's way too much, back to bed.": 2,
		},
	},
	{
		"expression": expressions["sad"],
		"text": "Bro you're just mad I can beat you.",
		"character": bodies["pink"],
		"choices": {
			"Stop lying, I'm going back to sleep.": 0,
			"Alright, fine then I'll show you.": 1,
		},
	},
	{
		"expression": expressions["happy"],
		"text": "Sure! [wave] First to two wins. [/wave]",
		"character": bodies["pink"],
		"choices": {"Okay! (Quit)": - 1},
	},
]

@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer
@onready var body = %Body
@onready var expression_texture_rect: TextureRect = %Expression
@onready var action_buttons_v_box_container = $VBoxContainer/ActionButtonsVBoxContainer
@onready var rich_text_label = %RichTextLabel

func _ready() -> void:
	show_text(0)

func show_text(current_item_index: int) -> void:
	var current_item := dialogue_items[current_item_index]
	rich_text_label.text = current_item["text"]
	expression_texture_rect.texture = current_item["expression"]
	body.texture = current_item["character"]
	create_buttons(current_item["choices"])
	rich_text_label.visible_ratio = 0.0
	var tween := create_tween()
	var text_appearing_duration: float = current_item["text"].length() / 30.0
	tween.tween_property(rich_text_label, "visible_ratio", 1.0, text_appearing_duration)
	var sound_max_length := audio_stream_player.stream.get_length() - text_appearing_duration
	var sound_start_position := randf() * sound_max_length
	audio_stream_player.play(sound_start_position)
	tween.finished.connect(audio_stream_player.stop)
	slide_in()
	for button: Button in action_buttons_v_box_container.get_children():
		button.disabled = true
	tween.finished.connect(func() -> void:
		for button: Button in action_buttons_v_box_container.get_children():
			button.disabled = false
	)
func slide_in() -> void:
	var slide_tween := create_tween()
	slide_tween.set_ease(Tween.EASE_OUT)
	body.position.x = get_viewport_rect().size.x / 7
	slide_tween.tween_property(body, "position:x", 0, 0.3)
	body.modulate.a = 0
	slide_tween.parallel().tween_property(body, "modulate:a", 1, 0.2)

func create_buttons(choices_data: Dictionary) -> void:
	for button in action_buttons_v_box_container.get_children():
		button.queue_free()
	for choice_text in choices_data:
		var button := Button.new()
		action_buttons_v_box_container.add_child(button)
		button.text = choice_text
		var target_line_idx: int = choices_data[choice_text]
		if target_line_idx == - 1:
			button.pressed.connect(get_tree().quit)
		else:
			button.pressed.connect(show_text.bind(target_line_idx))
