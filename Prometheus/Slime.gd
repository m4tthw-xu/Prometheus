extends KinematicBody2D


const GRAVITY = 30
const SPEED = 50
const FLOOR = Vector2(0,-1)

var velocity = Vector2()

var direction = 1

var is_dead = false

# gets called when slime dies
func dead():
	is_dead = true
	velocity = Vector2(0,0)
	$CollisionShape2D.disabled = true	
	$AnimatedSprite.play("dead")
	
	# will increase the player's kill count by 1 when slime dies
	var player_path = "/root/" + get_parent().name + "/Player"
	get_node(player_path).kills += 1



func _physics_process(delta):
	
	if is_dead == false:
		velocity.x = SPEED * direction
		
		# the sprite is uploaded looking like it's moving left, so the
		# flip_h property is reversed on how it normally should be
		if direction == 1:
			$AnimatedSprite.flip_h = true
		if direction == -1:
			$AnimatedSprite.flip_h = false
			
		$AnimatedSprite.play("idle")
		velocity.y += GRAVITY
		velocity = move_and_slide(velocity, FLOOR)
		
		if is_on_wall():
			direction *= -1
			$RayCast2D.position.x *= -1
		
		if $RayCast2D.is_colliding() == false:
			direction *= -1
			$RayCast2D.position.x *= -1
		
		

# slime disappears when he gets vaporized
func _on_AnimatedSprite_animation_finished():
	if is_dead == true:
		queue_free()
