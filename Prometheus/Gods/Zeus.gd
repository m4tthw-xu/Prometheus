extends KinematicBody2D

const LIGHTNING = preload("res://Gods/lightning.tscn")

const HIDDENSTAIRS = preload("res://hiddenstairszeus.tscn")
const PORTAL = preload("res://ChangeStage.tscn")

var GRAVITY = 300
var gravity_rand = RandomNumberGenerator.new()

var SPEED = 40
var speed_rand = RandomNumberGenerator.new()

var health = 5
var dmg_cool = 20

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
	if dmg_cool>0:
		dmg_cool-=1;
	
	$Health.setValue(health/5.0*100);
	
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
	$AnimatedSprite.play("death")
	previous_animation = "death"
	#queue_free();

func _on_AttackTimer_timeout():
	if previous_animation != "death":
		$AnimatedSprite.play("attack")
		previous_animation = "attack"
		currently_attacking = false
		can_attack = true
	


func _on_AnimatedSprite_animation_finished():
	if previous_animation == "death":
		#$AnimatedSprite.play("death");
		
		var hiddenstairs = HIDDENSTAIRS.instance()
		var portal = PORTAL.instance()
		portal.target_stage = "finalcutscene.tscn"
		get_parent().add_child(portal)
		get_parent().add_child(hiddenstairs)
		hiddenstairs.position = Vector2(0, 0)
		portal.position = Vector2(160, -192)
		queue_free();

func decreaseHealth():
	if dmg_cool <=0:
		health-=1;
		dmg_cool = 20;
		if health<=0:
			dead();
