extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	mouse_entered.connect(_on_mouse_entered)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
