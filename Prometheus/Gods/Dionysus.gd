extends KinematicBody2D

const GRAVITY = 150
const SPEED = 80

const BOTTLE = preload("res://Gods/DionysusBottle.tscn")
const PORTAL = preload("res://ChangeStage.tscn")
const HIDDENSTAIRS = preload("res://hiddenstairs.tscn")

var health = 3
var dmg_cool = 20

var is_dead = false

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

var up_bound_rand = 220
var low_bound_rand = 120

var up_rand = RandomNumberGenerator.new()
var low_rand = RandomNumberGenerator.new()

func _ready():
	set_process(true)
	pos_initial = true
	pos_final = false

func _randomize_boundaries():
	up_rand.randomize()
	low_rand.randomize()
	up_bound_rand = up_rand.randf_range(180, 220)
	low_bound_rand = low_rand.randf_range(115, 169)

func _randomize_jump():
	jump_rand.randomize()
	jump = jump_rand.randf_range(0, 40);
	
func _randomize_jump_power():
	jump_power_rand.randomize()
	jump_power = jump_power_rand.randf_range(100, 150)

func _process(delta):
	var move = Vector2()
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
	if dmg_cool>0:
		dmg_cool-=1;
	
	$Health.setValue(health/3.0*100);
	
	if is_dead == false:
		
		if currently_attacking == false:
			#$AnimatedSprite.play("idle")
			var hi = 2
			
		if can_attack == true:
			can_attack = false
			currently_attacking = true
			
			$AttackTimer.start()
			
		if is_on_floor():
			_randomize_jump()
		velocity.y += delta * GRAVITY
		if jump < 1 and is_on_floor():
			_randomize_jump_power()
			velocity.y = -jump_power
		velocity = move_and_slide(velocity, Vector2.UP)
	

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
	if previous_animation == "dead":
		var hiddenstairs = HIDDENSTAIRS.instance()
		get_parent().add_child(hiddenstairs)
		var portal = PORTAL.instance()
		portal.target_stage = "StageTwo.tscn"
		get_parent().add_child(portal)
		portal.position = Vector2(300, 48)
		queue_free()
	if previous_animation == "attack":
		# spawns the bottle into the game
		var bottle = BOTTLE.instance()
		get_parent().add_child(bottle)
		bottle.position = $Position2D.global_position
		$AnimatedSprite.play("idle")
		
func decreaseHealth():
	if dmg_cool <= 0:
		health-=1;
		dmg_cool = 20;
		if health <=0:
			dead();
