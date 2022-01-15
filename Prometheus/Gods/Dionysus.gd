extends KinematicBody2D

const GRAVITY = 30
const SPEED = 50


const BOTTLE = preload("res://Gods/DionysusBottle.tscn")

var is_dead = false

# this variable is for the attack cooldown
# works with $AttackTimer
var can_attack = true

var currently_attacking = false

var previous_animation = "idle"

func _physics_process(delta):
	if is_dead == false:
		
		if currently_attacking == false:
			#$AnimatedSprite.play("idle")
			var hi = 2
			
		if can_attack == true:
			can_attack = false
			currently_attacking = true
			
			
			
			$AttackTimer.start()

func dead():
	$CollisionShape2D.disabled = true
	$AnimatedSprite.play("dead")
	previous_animation = "dead"

func _on_AttackTimer_timeout():
	if previous_animation != "dead":
		$AnimatedSprite.play("attack")
		previous_animation = "attack"


		currently_attacking = false
		can_attack = true


func _on_AnimatedSprite_animation_finished():
	if previous_animation == "dead":
		queue_free()
	if previous_animation == "attack":
		# spawns the bottle into the game
		var bottle = BOTTLE.instance()
		get_parent().add_child(bottle)
		bottle.position = $Position2D.global_position
		$AnimatedSprite.play("idle")
		
