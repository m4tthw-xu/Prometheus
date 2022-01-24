extends Node2D


func _ready():
	MasterData.health = 100
	MasterData.player_location = "StageThree"
	$AudioStreamPlayer2D2.play()
	$AudioStreamPlayer2D.play()
