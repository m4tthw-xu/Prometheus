extends Area2D

# speed of the fireball
const SPEED = 80
var velocity = Vector2()

func _read():
	pass
	

# can use translate instead of move_and_slide cuz it doesn't interact w anything
func _physics_process(delta):
	# -1 means the bottle moves left
	velocity.x = SPEED * delta * -1
	translate(velocity)


# this destroys the fireball from memory, game, etc when the fireball exists the screen
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()



func _on_DionysusBottle_body_entered(body):
	queue_free()
