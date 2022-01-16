extends Node2D

const HALF_HEART = preload("res://sprites/half_heart2.png")
const FULL_HEART = preload("res://sprites/full_heart2.png")
const BLANK_HEART = preload("res://sprites/blank_heart.png")

func _ready():
	MasterData.health = 100
	MasterData.health_p2 = 100

func _physics_process(delta):
	
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
