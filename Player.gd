extends KinematicBody2D

# Controls:
# w: jump
# space: jump
# a: move left
# d: move right
# t: shoot fireball

const SPEED = 75
const GRAVITY = 30
const JUMP_POWER = -275
const FLOOR = Vector2(0,-1)

const FIREBALL = preload("res://Fireball.tscn")

var velocity = Vector2()

var on_ground = false

func _physics_process(delta):
	if Input.is_action_pressed("ui_d"):
		velocity.x = SPEED
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = false
	elif Input.is_action_pressed("ui_a"):
		velocity.x = -SPEED
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = true
	else:
		velocity.x = 0
		if on_ground == true:
			$AnimatedSprite.play("idle")
		
	if Input.is_action_pressed("ui_accept") or Input.is_action_pressed("ui_w"): #ui_accept is the space bar or enter bar
		if on_ground == true:
			velocity.y = JUMP_POWER
			on_ground = false
	
	if Input.is_action_just_pressed("ui_t"):
		var fireball = FIREBALL.instance()
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
