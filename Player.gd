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

const FIREBALL = preload("res://Fireball.tscn")

var velocity = Vector2()

var on_ground = false

var is_attacking = false

func input_process(actor, event):
	if event.is_action_pressed(actor.jump):
		if actor.has_node("pass_through") and Input.is_action_pressed("ui_s"):
			actor.set_collision_mask_bit(1,false)
		else:
			actor.jump

func _physics_process(delta):
	
	if Input.is_action_pressed("ui_d"):
		velocity.x = SPEED
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = false
		if sign($Position2D.position.x) == -1:
			$Position2D.position.x *= -1
	elif Input.is_action_pressed("ui_a"):
		velocity.x = -SPEED
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = true
		if sign($Position2D.position.x) == 1:
			$Position2D.position.x *= -1
	else:
		velocity.x = 0
		if on_ground == true:
			$AnimatedSprite.play("idle")
		
	if Input.is_action_pressed("ui_accept") or Input.is_action_pressed("ui_w"): #ui_accept is the space bar or enter bar
		if on_ground == true:
			velocity.y = JUMP_POWER
			on_ground = false
	
	# player can only attack after shooting animation completes
	if Input.is_action_just_pressed("ui_t"):
		is_attacking = true
		# need to add once we have a shooting animation
		# $AnimatedSprite.play("attack")
		var fireball = FIREBALL.instance()
		if sign($Position2D.position.x) == 1:
			fireball.set_fireball_direction(1)
		else:
			fireball.set_fireball_direction(-1)
		get_parent().add_child(fireball)
		fireball.position = $Position2D.global_position
	
	velocity.y = velocity.y + GRAVITY
	
	if is_on_floor():
		on_ground = true
	else:
		on_ground = false
		if velocity.y <0:
			$AnimatedSprite.play("jump")
		else:
			$AnimatedSprite.play("fall")
	
	velocity = move_and_slide(velocity, FLOOR)


# pass through platform function tutorial: https://www.youtube.com/watch?v=T704Zrlye2k&ab_channel=Pigdev
