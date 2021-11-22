extends Area2D

const SPEED = 100
var velocity = Vector2()

func _read():
	pass
	

# can use translate instead of move_and_slide cuz it doesn't interact w anything
func _physics_process(delta):
	velocity.x = SPEED * delta
	translate(velocity)
	$AnimatedSprite.play("shoot")


# this destroys the fireball from memory, game, etc when the fireball exists the screen
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
