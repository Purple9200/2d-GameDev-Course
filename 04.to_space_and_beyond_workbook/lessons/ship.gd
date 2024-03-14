extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
var velocity := Vector2(500,0)

func _process(delta: float) -> void:
	position += velocity * delta
	rotation = velocity.angle()
