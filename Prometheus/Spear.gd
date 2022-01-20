extends Area2D

# speed of the fireball
const SPEED = 200
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
	velocity.y = 0.1
	translate(velocity)
	$AnimatedSprite.play("shoot")


# this destroys the fireball from memory, game, etc when the fireball exists the screen
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func enemy_killed():
	if get_tree().get_current_scene().name == "StageOne":
		MasterData.enemies_slain_stage_one += 1
	if get_tree().get_current_scene().name == "StageTwo":
		MasterData.enemies_slain_stage_two += 1
	if get_tree().get_current_scene().name == "StageThree":
		MasterData.enemies_slain_stage_three += 1

func _on_Spear_body_entered(body):
	for enemy_name in MasterData.enemy_names:
		if enemy_name in body.name:
			if enemy_name == "Golem" or enemy_name == "Dionysus" or enemy_name == "Zeus":
				body.decreaseHealth();
		elif enemy_name in body.name:
			body.dead()
			enemy_killed()
	if body.name.find("Player2") != -1:
		MasterData.health_p2 = MasterData.health_p2 - 20
	
		
	queue_free()
