extends Node2D
const HALF_HEART = preload("res://sprites/half_heart2.png")
const FULL_HEART = preload("res://sprites/full_heart2.png")
const BLANK_HEART = preload("res://sprites/blank_heart.png")
var speed = 0.25

func _ready():
	MasterData.health = 100
	MasterData.player_location = "Multiplayer"
	MasterData.health_p2 = 100

func _set_speed():
	$Sprite.position.y = $Sprite.position.y + speed

func _physics_process(delta):
	
	if $Sprite.position.y <= -1792:
		speed = 0.25
	elif $Sprite.position.y >= 2000:
		speed = -0.25
		
	_set_speed()
	#print(MasterData.kills_p1)
	$Score.text = str(MasterData.kills_p1) + " - " + str(MasterData.kills_p2)
	if MasterData.health_p2 == 100:
		$heart5.set_texture(FULL_HEART)
		$heart4.set_texture(FULL_HEART)
		$heart3.set_texture(FULL_HEART)
		$heart2.set_texture(FULL_HEART)
		$heart1.set_texture(FULL_HEART)
	
	# display p2 health
	if MasterData.health_p2 <= 90:
		$heart5.set_texture(HALF_HEART)
	if MasterData.health_p2 <= 80:
		$heart5.set_texture(BLANK_HEART)
	if MasterData.health_p2 <= 70:
		$heart4.set_texture(HALF_HEART)
	if MasterData.health_p2 <= 60:
		$heart4.set_texture(BLANK_HEART)
	if MasterData.health_p2 <= 50:
		$heart3.set_texture(HALF_HEART)
	if MasterData.health_p2 <= 40:
		$heart3.set_texture(BLANK_HEART)
	if MasterData.health_p2 <= 30:
		$heart2.set_texture(HALF_HEART)
	if MasterData.health_p2 <= 20:
		$heart2.set_texture(BLANK_HEART)
	if MasterData.health_p2 <= 10:
		$heart1.set_texture(HALF_HEART)
	if MasterData.health_p2 <= 0:
		$heart1.set_texture(BLANK_HEART)

