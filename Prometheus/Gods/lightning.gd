extends Area2D

# speed of the fireball
var velocity = Vector2()

func _ready():
	if MasterData.zeus_facing == "left":
		scale = Vector2(1, 1)
		velocity.x = -2
	else:
		scale = Vector2(-1, 1)
		velocity.x = 2
	pass
	

# can use translate instead of move_and_slide cuz it doesn't interact w anything
func _physics_process(delta):
	# -1 means the bottle moves left
	velocity.y = 75 * delta
	translate(velocity)


# this destroys the fireball from memory, game, etc when the fireball exists the screen
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()



func _on_lightning_body_entered(body):
	queue_free()
