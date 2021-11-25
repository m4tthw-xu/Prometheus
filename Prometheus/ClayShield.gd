extends KinematicBody2D

# logic is parts taken from Player.gd
const GRAVITY = 30
const FLOOR = Vector2(0,-1)
var velocity = Vector2()
var on_ground = false

# Called when the node enters the scene tree for the first time.
func _read():
	pass


func _physics_process(delta):

	velocity.y = velocity.y + GRAVITY
	
	# jumping/falling animation
	if is_on_floor():
		on_ground = true
	else:
		on_ground = false
	
	velocity = move_and_slide(velocity, FLOOR)

func play_animation():
	$AnimatedSprite.play("default")


func _on_AnimatedSprite_animation_finished():
	queue_free()
