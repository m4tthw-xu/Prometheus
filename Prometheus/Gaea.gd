extends KinematicBody2D

const GRAVITY = 250
const SPEED = 100
const PORTAL = preload("res://ChangeStage.tscn")

const GOLEM = preload("res://Golem.tscn")

var is_dead = false

var health = 2
var dmg_cool = 20

var velocity = Vector2()
var on_ground = true

# this variable is for the attack cooldown
# works with $AttackTimer
var can_attack = true

var currently_attacking = false

var previous_animation = "idle"

var pos_initial = false
var pos_final = false

var jump_rand = RandomNumberGenerator.new()
var jump = 0
var jump_power_rand = RandomNumberGenerator.new()
var jump_power = 0
var jump_disable = false

var up_bound_rand = 220
var low_bound_rand = 120

var up_rand = RandomNumberGenerator.new()
var low_rand = RandomNumberGenerator.new()

var golem_x_spawn_rand = RandomNumberGenerator.new()
var golem_x_spawn = 0

var gaea_x_pos = 0;
var facing = "left"

func _randomize_golem_spawn():
	golem_x_spawn_rand.randomize()
	golem_x_spawn = golem_x_spawn_rand.randf_range(40, 280)

func _randomize_jump():
	jump_rand.randomize()
	jump = jump_rand.randf_range(0, 20);
	
func _randomize_jump_power():
	jump_power_rand.randomize()
	jump_power = jump_power_rand.randf_range(80, 170)


func _ready():
	MasterData.golem_count = 0
	set_process(true)
	pos_initial = true
	pos_final = false

func _randomize_boundaries():
	up_rand.randomize()
	low_rand.randomize()
	up_bound_rand = up_rand.randf_range(200, 275)
	low_bound_rand = low_rand.randf_range(50, 125)


func _process(delta):
	var move = Vector2()
	if !is_dead:
		if pos_initial:
			move.x = SPEED
			if position.x >= up_bound_rand:
				pos_initial = false
				pos_final = true
				_randomize_boundaries()

		if pos_final:
			move.x = -SPEED
			if position.x <= low_bound_rand:
				pos_initial = true
				pos_final = false
				_randomize_boundaries()
				
	
	position += move * delta

func _physics_process(delta):
	if dmg_cool>=0:
		dmg_cool-=1;
	
	
	if Input.is_action_just_released("ui_]"):
		dead()
	
	if is_dead == false:
		
		if is_on_floor() && !jump_disable:
			_randomize_jump()
		velocity.y += delta * GRAVITY
		if jump < 1 and is_on_floor() && !jump_disable:
			_randomize_jump_power()
			velocity.y = -jump_power
		velocity = move_and_slide(velocity, Vector2.UP)
		
		if currently_attacking == false:
			#$AnimatedSprite.play("idle")
			var hi = 2
			
		if can_attack == true:
			can_attack = false
			currently_attacking = true
			
			$AttackTimer.start()
		
	 
	velocity = move_and_slide(velocity, Vector2.UP)

func dead():
	is_dead = true
	get_node("CollisionShape2D").disabled = true
	velocity.y = 100
	var portal = PORTAL.instance()
	portal.target_stage = "StageThree.tscn"
	get_parent().add_child(portal)
	portal.position = Vector2(160, 64)
	
	if self.position.y > 200:
		queue_free()


func _on_AttackTimer_timeout():
	if previous_animation != "dead":
		
		if MasterData.golem_count < 3 && !is_dead:
			jump_disable = true
			$AnimatedSprite.play("attack")
			var golem = GOLEM.instance()
			get_parent().add_child(golem)
			_randomize_golem_spawn()
			golem.position = Vector2(golem_x_spawn, -110)
			MasterData.golem_count += 1
			jump_disable = false
		
		previous_animation = "attack"
		currently_attacking = false
		can_attack = true
	
func _on_AnimatedSprite_animation_finished():
	if previous_animation == "dead":
		
		queue_free()
	if previous_animation == "attack":
		# spawns the bottle into the game
		$AnimatedSprite.play("idle")


func decreaseHealth():
	print("ree");
	if dmg_cool <= 0:
		health-=1;
		
		dmg_cool = 20;
		if health <=0:
			dead();
