extends KinematicBody2D


const GRAVITY = 2
const SPEED = 50
const FLOOR = Vector2(0,-1)

var velocity = Vector2()

var direction = 1

var is_dead = false

var health = 2

var is_attacking = false
var previous_animation = ""

var player_obj = preload("res://Player.tscn")

# gets called when golem dies
func dead():
	$MeleeCooldown.stop()
	is_dead = true
	velocity = Vector2(0,0)
	$CollisionShape2D.disabled = true
	$AnimatedSprite.position.x = 0

	$AnimatedSprite.play("dead")
	
	# will increase the player's kill count by 1 when slime dies
	var player_path = "/root/" + get_parent().name + "/Player"
	get_node(player_path).kills += 1
	MasterData.golem_count = MasterData.golem_count - 1



func _physics_process(delta):
	
	if is_dead == false:
		
		for obj in $Melee.get_overlapping_bodies():
			if obj.name.find("Player") != -1 and is_attacking == false:
				if direction == 1:
					$AnimatedSprite.position.x = 24
				if direction == -1:
					$AnimatedSprite.position.x = -24
					
				is_attacking = true
				previous_animation = "attack"
				$AnimatedSprite.play("attack")
				$MeleeCooldown.start()
				MasterData.health = MasterData.health - 20
		
		if is_attacking == false:
			previous_animation = "idle"
			$AnimatedSprite.play("idle")
			$AnimatedSprite.position.x = 0
			previous_animation = "idle"
		
		
			velocity.x = SPEED * direction
			
			# the sprite is uploaded looking like it's moving left, so the
			# flip_h property is reversed on how it normally should be
			if direction == 1:
				$AnimatedSprite.flip_h = true
				$Melee.position.x = 44
			if direction == -1:
				$AnimatedSprite.flip_h = false
				$Melee.position.x = -44
				
			
			velocity.y += GRAVITY
			velocity = move_and_slide(velocity, FLOOR)
		
		
		
			if is_on_wall():
				direction *= -1
				$RayCast2D.position.x *= -1
			
			if $RayCast2D.is_colliding() == false:
				direction *= -1
				$RayCast2D.position.x *= -1
		


func _on_AnimatedSprite_animation_finished():
	if is_dead == true:
		queue_free()


func _on_MeleeCooldown_timeout():
	is_attacking = false
	$AnimatedSprite.position.x = 0
	previous_animation == "idle"
	$AnimatedSprite.play("idle")

func decreaseHealth():
	health-=1
	if health<=0:
		dead()
