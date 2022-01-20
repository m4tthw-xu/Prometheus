extends Node2D

func _ready():
	MasterData.health = 80
	MasterData.player_location = "StageTwo"
	$AudioStreamPlayer2D2.play()
	$AudioStreamPlayer2D.play()
