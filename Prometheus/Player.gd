extends KinematicBody2D


const SPEED = 85
const GRAVITY = 30
const JUMP_POWER = -350
const FLOOR = Vector2(0,-1)

const SPEAR = preload("res://Spear.tscn")
const CLAYSHIELD = preload("res://ClayShield.tscn")
const HALF_HEART = preload("res://sprites/half_heart.png")
const FULL_HEART = preload("res://sprites/full_heart.png")

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

# can only shield every 3 seconds
# works with $WallTimer
var wall_delay = false

# can only use spear every 2 seconds
# works with $SpearTimer
var spear_delay = false

# score is determined by height + slimes killed
var score = 0
var height = 0
var kills = 0

var health = 100

# a 1 second timer so person can only take damage once a second
var can_take_damage = true

# used for the death function of the character
var is_dead = false


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
		if Input.is_action_pressed("ui_d"):
			velocity.x = SPEED
			$Melee.position.x = 12
			direction = "left"
			if is_attacking == false:
				$AnimatedSprite.play("run")
			if sign($Position2D.position.x) == -1:
				$Position2D.position.x *= -1
		elif Input.is_action_pressed("ui_a"):
			velocity.x = -SPEED
			$Melee.position.x = -12
			direction = "right"
			if is_attacking == false:
				$AnimatedSprite.play("run")
			if sign($Position2D.position.x) == 1:
				$Position2D.position.x *= -1
		else:
			velocity.x = 0
			if on_ground == true:
				if is_attacking == false:
					$AnimatedSprite.play("idle")
		if is_attacking == false:
			if direction == "left":
				$AnimatedSprite.flip_h = false
			if direction == "right":
				$AnimatedSprite.flip_h = true
			
		# jump mechanics
		if Input.is_action_pressed("ui_accept") or Input.is_action_pressed("ui_w"): #ui_accept is the space bar or enter bar
			if on_ground == true:
				velocity.y = JUMP_POWER
				on_ground = false
		
		# player can only attack after shooting animation completes
		if Input.is_action_just_pressed("ui_t"):
			if $AnimatedSprite.animation != "sword" and spear_delay == false:
				is_attacking = true
				spear_delay = true
				$SpearTimer.start()
				
				$AnimatedSprite.play("spear")
				var spear = SPEAR.instance()
				if sign($Position2D.position.x) == 1:
					spear.set_fireball_direction(1)
				else:
					spear.set_fireball_direction(-1)
				get_parent().add_child(spear)
				spear.position = $Position2D.global_position
		if Input.is_action_just_pressed("ui_g"):
			if $AnimatedSprite.animation != "spear" and sword_delay == false:
				is_attacking = true
				sword_delay = true
				$MeleeTimer.start()
				
				if direction == "left":
					$AnimatedSprite.offset.x = 14
				elif direction == "right":
					$AnimatedSprite.offset.x = -14

				$AnimatedSprite.play("sword")
		
		if $AnimatedSprite.animation == "sword":
			for obj in $Melee.get_overlapping_bodies():
				if obj.name.find("Slime") != -1:
					obj.dead()
				if obj.name.find("Dionysus") != -1:
					obj.dead()
		
		#spawns a wall on left and right side of the player
		if Input.is_action_just_pressed("ui_h"):
			if is_attacking == false && wall_delay == false && on_ground == true:
				wall_delay = true
				$WallTimer.start()
				
				# check areas left and right side of player if an enemy exists
				# if so, then kill the enemy
				for obj in $WallAreaCheckerLeft.get_overlapping_bodies():
					if obj.name.find("Slime") != -1:
						obj.dead()
				for obj in $WallAreaCheckerRight.get_overlapping_bodies():
					if obj.name.find("Slime") != -1:
						obj.dead()
				print($WallAreaCheckerLeft.get_overlapping_bodies())
				
				var tile_exists = false
				for obj in $WallAreaCheckerLeft.get_overlapping_bodies():
					if obj.name.find("TileMap") != -1:
						tile_exists = true
				if tile_exists == false:
					var clay_wall_left = CLAYSHIELD.instance()
					get_parent().add_child(clay_wall_left)
					clay_wall_left.position = $ClayWallLeft.global_position
					clay_wall_left.play_animation()
				
				tile_exists = false
				for obj in $WallAreaCheckerRight.get_overlapping_bodies():
					if obj.name.find("TileMap") != -1:
						tile_exists = true
				if tile_exists == false:
					var clay_wall_right = CLAYSHIELD.instance()
					get_parent().add_child(clay_wall_right)
					clay_wall_right.position = $ClayWallRight.global_position
					clay_wall_right.play_animation()
				
		
		
		# update score
		# 145.5 is starting height
		var height_difference = 145.5 - self.position.y
		height = int(height_difference/16) # divide by 16 cuz that's the block size
		score = height + kills

		
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
		
		# health logic
		if can_take_damage == true:
			for obj in $BodyArea.get_overlapping_bodies():
				if obj.name.find("Slime") != -1:
					health = health - 10
					can_take_damage = false
					$DamageDelay.start(1)
			for obj in $BodyArea.get_overlapping_areas():
				if obj.name.find("DionysusBottle") != -1:
					health = health -20
					can_take_damage = false
					$DamageDelay.start(1)
	
	# display
	if health <= 90:
		$CanvasLayer/PlayerStats/heart5.set_texture(HALF_HEART)
	if health <= 80:
		$CanvasLayer/PlayerStats/heart5.set_texture(null)
	if health <= 70:
		$CanvasLayer/PlayerStats/heart4.set_texture(HALF_HEART)
	if health <= 60:
		$CanvasLayer/PlayerStats/heart4.set_texture(null)
	if health <= 50:
		$CanvasLayer/PlayerStats/heart3.set_texture(HALF_HEART)
	if health <= 40:
		$CanvasLayer/PlayerStats/heart3.set_texture(null)
	if health <= 30:
		$CanvasLayer/PlayerStats/heart2.set_texture(HALF_HEART)
	if health <= 20:
		$CanvasLayer/PlayerStats/heart2.set_texture(null)
	if health <= 10:
		$CanvasLayer/PlayerStats/heart1.set_texture(HALF_HEART)
	if health <= 0:
		$CanvasLayer/PlayerStats/heart1.set_texture(null)
	
	# death function
	if health <= 0:
		dead()
	
# pass through platform function tutorial: https://www.youtube.com/watch?v=T704Zrlye2k&ab_channel=Pigdev

func dead():
	is_dead = true
	
	
	if $AnimatedSprite.animation != "death":
		$AnimatedSprite.play("death")
	previous_animation = "death"
	

func _on_AnimatedSprite_animation_finished():
	if previous_animation == "sword":
		# changes to idle first because if not, the character will offset back to 0 without
		# finishing changing its animation, creating a glitching effect
		$AnimatedSprite.play("idle")
		$AnimatedSprite.offset.x = 0
	if previous_animation == "spear" or previous_animation == "sword":
		is_attacking = false
	if previous_animation == "death":
		$CollisionShape2D.disabled = true
		$DeathTimer.start()



func _on_MeleeTimer_timeout():
	sword_delay = false


func _on_WallTimer_timeout():
	wall_delay = false


func _on_DeathTimer_timeout():
	get_tree().change_scene("res://StageOne.tscn")


func _on_DamageDelay_timeout():
	can_take_damage = true


func _on_SpearTimer_timeout():
	spear_delay = false
