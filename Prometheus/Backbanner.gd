extends Sprite


# Declare member variables here. Examples:
var spd = 20
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	#get_position_in_parent() += spd
	Transform2D.translated(Vector2(0, 10))
	velocity.y = 1
	pass
