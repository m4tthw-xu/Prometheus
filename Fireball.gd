extends Area2D

# speed of the fireball
const SPEED = 125
var velocity = Vector2()
# -1 is fireball face to left, 1 is facing to right
var direction = 1

func _read():
	pass
	
func set_fireball_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true

# can use translate instead of move_and_slide cuz it doesn't interact w anything
func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)
	$AnimatedSprite.play("shoot")


# this destroys the fireball from memory, game, etc when the fireball exists the screen
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Fireball_body_entered(body):
	if "Slime" in body.name:
		body.dead()
	queue_free()
