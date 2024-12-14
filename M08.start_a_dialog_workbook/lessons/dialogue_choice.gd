##This resource is inside the dialoguechoice
@icon("res://assets/dialogue_choice_icon.svg")
class_name DialogueChoice extends Resource
##This is text for your dialogue.
@export var text := ""
##Target Line index is used to count dialogue items.
@export_range(0, 20) var target_line_idx := 0
@export var is_quit := false
