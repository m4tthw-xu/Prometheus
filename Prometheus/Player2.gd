extends KinematicBody2D


const SPEED = 70
const GRAVITY = 30
const JUMP_POWER = -350
const FLOOR = Vector2(0,-1)


var velocity = Vector2()

var on_ground = false

# only changes animation after the attack animation is done
var is_attacking = false
var previous_animation = "idle"

# if direction changes while attack animation is still playing, the direction is
# stored in the "direction" variable, and then will change once attack is finished
var direction = "left"

# can only attack every 0.4 seconds
# works with $MeleeTimer
var sword_delay = false


# a 1 second timer so person can only take damage once a second
var can_take_damage = true

# used for the death function of the character
var is_dead = false

# varriables for acceleration and gliding
var time_start = 0
var time_now = 0
var time_elapsed = 0

var current_speed = 0
var modspeed = 0

# establishes a start time for the player to accelerate
func _ready():
	time_start = 0
	time_now = 0
	time_elapsed = 0
	time_start = OS.get_ticks_msec()
	#direction = "right"


# tracks the time elapsed to calculate how the player accelerates
func _time_process():
	time_now = 0
	time_now = OS.get_ticks_msec()
	time_elapsed = 0
	if time_elapsed > 1000:
		time_elapsed = 1000
	else:
		time_elapsed = time_now - time_start

# this is for the passthrough function of platforms
func input_process(actor, event):
	if event.is_action_pressed(actor.jump):
		if actor.has_node("pass_through") and Input.is_action_pressed("ui_s"):
			actor.set_collision_mask_bit(1,false)
		else:
			actor.jump

func _physics_process(delta):
	

	if is_dead == false:
	
		# running left and right animations and mechanics
		# will not flip direction of sprite until the attack animation is done
		if Input.is_action_pressed("ui_'") and !Input.is_action_pressed("ui_l"):
			
			_time_process()
			
			# acceleration algorithm: speeds up to a max speed of SPEED + 50
			# 50 is the greatest added speed
			modspeed = (time_elapsed / 12)
			if modspeed > 65:
				velocity.x = SPEED + 50
				current_speed = SPEED + 50
			else:
				velocity.x = SPEED + modspeed
				current_speed = SPEED + modspeed
			
			$Melee.position.x = 12
			direction = "left"
			if is_attacking == false:
				$AnimatedSprite.play("run")
				
			if !Input.is_action_pressed("ui_'"):
				_ready()
		elif Input.is_action_pressed("ui_l") and !Input.is_action_pressed("ui_'"):
			_time_process()
			
			modspeed = (time_elapsed / 12)
			if modspeed > 50:
				velocity.x = -SPEED - 50
				current_speed = -SPEED - 50
			else:
				velocity.x = -SPEED - modspeed
				current_speed = -SPEED - modspeed
			
			$Melee.position.x = -12
			direction = "right"
			if is_attacking == false:
				$AnimatedSprite.play("run")
			
			if !Input.is_action_pressed("ui_l"):
				_ready()
		elif !Input.is_action_pressed("ui_l") and !Input.is_action_pressed("ui_'"):
			velocity.x = 0
			if on_ground == true:
				if is_attacking == false:
					$AnimatedSprite.play("idle")
			_ready()
					
		if is_attacking == false:
			if direction == "left":
				$AnimatedSprite.flip_h = false
			if direction == "right":
				$AnimatedSprite.flip_h = true
			
		# jump mechanics
		if Input.is_action_pressed("ui_accept") or Input.is_action_pressed("ui_p"): #ui_accept is the space bar or enter bar
			if on_ground == true:
				velocity.y = JUMP_POWER
				on_ground = false
		
		# player can only attack after shooting animation completes
				
		if Input.is_action_just_pressed("ui_]"):
			if  sword_delay == false:
				is_attacking = true
				sword_delay = true
				$MeleeTimer.start()
				
				if direction == "left":
					$AnimatedSprite.offset.x = 8
				elif direction == "right":
					$AnimatedSprite.offset.x = -8
				
				for obj in $Melee.get_overlapping_bodies():
					if obj.name == "Player":
						MasterData.health = MasterData.health - 40
				$AnimatedSprite.play("sword")
				
		
		velocity.y = velocity.y + GRAVITY
		
		# jumping/falling animation
		if is_on_floor():
			on_ground = true
			current_speed = 0
		else:
			on_ground = false
			if direction == "left" and !Input.is_action_pressed("ui_'"):
				velocity.x = current_speed / 1.5
			elif direction == "right" and !Input.is_action_pressed("ui_l"):
				velocity.x = current_speed / 1.5
			if velocity.y <0:
				if is_attacking == false:
					$AnimatedSprite.play("jump")
			else:
				if is_attacking == false:
					$AnimatedSprite.play("fall")
		
		velocity = move_and_slide(velocity, FLOOR)
		
		previous_animation = $AnimatedSprite.animation
		
	
	
	
	# death function
	if MasterData.health_p2 <= 0:
		dead()
		
	
# pass through platform function tutorial: https://www.youtube.com/watch?v=T704Zrlye2k&ab_channel=Pigdev

func dead():
	
	
	if $AnimatedSprite.animation != "death" and previous_animation != "death":
		is_dead = true
		$AnimatedSprite.play("death")
		
		if get_tree().get_current_scene().name.find("Multiplayer") != -1:
			MasterData.kills_p1 = MasterData.kills_p1 + 1
		
	previous_animation = "death"

	


func _on_MeleeTimer_timeout():
	sword_delay = false


func _on_DeathTimer_timeout():
	pass

func _on_DamageDelay_timeout():
	can_take_damage = true


func _on_AnimatedSprite_animation_finished():
	if previous_animation == "sword":
		# changes to idle first because if not, the character will offset back to 0 without
		# finishing changing its animation, creating a glitching effect
		$AnimatedSprite.play("idle")
		$AnimatedSprite.offset.x = 0
	if previous_animation == "spear" or previous_animation == "sword":
		is_attacking = false
	if previous_animation == "death":
		$CollisionShape2D.disabled = false
		position.x = 298
		position.y = 160
		MasterData.health_p2 = 100
		is_dead = false
		
		$AnimatedSprite.play("idle")
		previous_animation == "idle"
