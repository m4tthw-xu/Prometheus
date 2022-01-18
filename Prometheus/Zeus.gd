extends KinematicBody2D

const LIGHTNING = preload("res://Gods/lightning.tscn")

var GRAVITY = 300
var gravity_rand = RandomNumberGenerator.new()

var SPEED = 40
var speed_rand = RandomNumberGenerator.new()

var is_dead = false

var velocity = Vector2()
var on_ground = true

var x_speed_rand = RandomNumberGenerator.new()
var x_speed = 40

var y_speed_rand = RandomNumberGenerator.new()
var y_speed = 40

# this variable is for the attack cooldown
# works with $AttackTimer
var can_attack = true

var currently_attacking = false

var previous_animation = "idle"

var pos_initial_x = false
var pos_final_x = false

var pos_final_y = false
var pos_initial_y = false

var facing = "left"

func _randomize_speeds():
	x_speed_rand.randomize()
	y_speed_rand.randomize()
	x_speed = x_speed_rand.randf_range(50, 130)
	y_speed = y_speed_rand.randf_range(70, 130)

func _ready():
	set_process(true)
	pos_initial_x = true
	pos_final_x = false
	pos_initial_y = true
	pos_final_y = false

func _process(delta):
	MasterData.zeus_x_pos = self.position.x
	var move = Vector2()
	
	if MasterData.player_x_pos > MasterData.zeus_x_pos:
		facing = "right"
	else:
		facing = "left"
	
	if pos_initial_x:
		move.x = x_speed
		if position.x >= 295:
			pos_initial_x = false
			pos_final_x = true
			_randomize_speeds()

	if pos_final_x:
		move.x = -x_speed
		if position.x <= 25:
			pos_initial_x = true
			pos_final_x = false
			_randomize_speeds()
	
	if pos_initial_y:
		move.y = y_speed
		if position.y >= 90:
			pos_initial_y = false
			pos_final_y = true
			_randomize_speeds()

	if pos_final_y:
		move.y = -y_speed
		if position.y <= 25:
			pos_initial_y = true
			pos_final_y = false
			_randomize_speeds()
	
	position.x += move.x * delta
	position.y += move.y * delta
	
	if facing == "right":
		scale = Vector2(-1, 1)
	else:
		scale = Vector2(1, 1)
	
	MasterData.zeus_facing = facing


func _physics_process(delta):
	if is_dead == false:
		
		if currently_attacking == false:
			$AnimatedSprite.play("idle")
			
		if can_attack == true:
			can_attack = false
			currently_attacking = true
			$AnimatedSprite.play("attack")
			var lightning = LIGHTNING.instance()
			get_parent().add_child(lightning)
			lightning.position = $Position2D.global_position
			$AttackTimer.start()
		
	

func dead():
	$AnimatedSprite.play("dead")
	previous_animation = "dead"

func _on_AttackTimer_timeout():
	if previous_animation != "dead":
		$AnimatedSprite.play("attack")
		previous_animation = "attack"
		currently_attacking = false
		can_attack = true


func _on_AnimatedSprite_animation_finished():
	pass

