extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
@onready var body = $Body
@onready var expression = $Body/Expression
@onready var button_sophia = $VBoxContainer/HBoxContainer/ButtonSophia
@onready var button_pink = $VBoxContainer/HBoxContainer/ButtonPink
@onready var button_regular = $VBoxContainer/HBoxContainer2/ButtonRegular
@onready var button_sad = $VBoxContainer/HBoxContainer2/ButtonSad
@onready var button_happy = $VBoxContainer/HBoxContainer2/ButtonHappy
