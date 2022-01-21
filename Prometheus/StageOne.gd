extends Node2D

var enemies_slain = 0

func _ready():
	MasterData.start_time = OS.get_unix_time()
	MasterData.enemies_slain_stage_one = 0
	MasterData.enemies_slain_stage_two = 0
	MasterData.enemies_slain_stage_three = 0
	MasterData.health = 100
	MasterData.spear_charges = 4
