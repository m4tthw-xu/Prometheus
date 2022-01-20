extends Node2D

func _ready():
	MasterData.health = 100
	$AudioStreamPlayer2D.play()
