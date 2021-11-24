extends KinematicBody2D

# Controls:
# w: jump
# space: jump
# a: move left
# d: move right
# t: shoot fireball

const SPEED = 85
const GRAVITY = 30
const JUMP_POWER = -350
const FLOOR = Vector2(0,-1)

const SPEAR = preload("res://Spear.tscn")

var velocity = Vector2()

var on_ground = false

# only changes animation after the attack animation is done
var is_attacking = false
var previous_animation = "idle"

func input_process(actor, event):
	if event.is_action_pressed(actor.jump):
		if actor.has_node("pass_through") and Input.is_action_pressed("ui_s"):
			actor.set_collision_mask_bit(1,false)
		else:
			actor.jump

func _physics_process(delta):
	
	# running left and right animations and mechanics
	if Input.is_action_pressed("ui_d"):
		velocity.x = SPEED
		$Melee.position.x = 12
		if is_attacking == false:
			$AnimatedSprite.play("run")
			$AnimatedSprite.flip_h = false
		if sign($Position2D.position.x) == -1:
			$Position2D.position.x *= -1
	elif Input.is_action_pressed("ui_a"):
		velocity.x = -SPEED
		$Melee.position.x = -12
		if is_attacking == false:
			$AnimatedSprite.play("run")
			$AnimatedSprite.flip_h = true
		if sign($Position2D.position.x) == 1:
			$Position2D.position.x *= -1
	else:
		velocity.x = 0
		if on_ground == true:
			if is_attacking == false:
				$AnimatedSprite.play("idle")
		
	# jump mechanics
	if Input.is_action_pressed("ui_accept") or Input.is_action_pressed("ui_w"): #ui_accept is the space bar or enter bar
		if on_ground == true:
			velocity.y = JUMP_POWER
			on_ground = false
	
	# player can only attack after shooting animation completes
	if Input.is_action_just_pressed("ui_t"):
		if $AnimatedSprite.animation != "sword":
			is_attacking = true
			# need to add once we have a shooting animation
			$AnimatedSprite.play("spear")
			var spear = SPEAR.instance()
			if sign($Position2D.position.x) == 1:
				spear.set_fireball_direction(1)
			else:
				spear.set_fireball_direction(-1)
			get_parent().add_child(spear)
			spear.position = $Position2D.global_position
	if Input.is_action_just_pressed("ui_g"):
		if $AnimatedSprite.animation != "spear":
			is_attacking = true
			if sign($Position2D.position.x) == 1:
				$AnimatedSprite.offset.x = 14
			if sign($Position2D.position.x) == -1:
				$AnimatedSprite.offset.x = -14
			
			print($Melee.get_overlapping_bodies())
			for bob in $Melee.get_overlapping_bodies():
				if bob.name.find("Slime") != -1:
					bob.dead()

		$AnimatedSprite.play("sword")

	
	velocity.y = velocity.y + GRAVITY
	
	# jumping/falling animation
	if is_on_floor():
		on_ground = true
	else:
		on_ground = false
		if velocity.y <0:
			if is_attacking == false:
				$AnimatedSprite.play("jump")
		else:
			if is_attacking == false:
				$AnimatedSprite.play("fall")
	
	velocity = move_and_slide(velocity, FLOOR)
	
	previous_animation = $AnimatedSprite.animation
	
	


# pass through platform function tutorial: https://www.youtube.com/watch?v=T704Zrlye2k&ab_channel=Pigdev


func _on_AnimatedSprite_animation_finished():
	if previous_animation == "sword":
		$AnimatedSprite.offset.x = 0
	if previous_animation == "spear" or previous_animation == "sword":
		is_attacking = false

