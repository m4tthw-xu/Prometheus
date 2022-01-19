extends Area2D

export(String, FILE, "*.tscn") var target_stage

var StageOne = preload("res://StageOne.gd")
var StageTwo = preload("res://StageTwo.gd")
var StageThree = preload("res://StageThree.gd")

func _ready():
	pass

# changes stage of current scene when player enters the area
func _on_ChangeStage_body_entered(body):
	if "Player" in body.name:
		
		if get_tree().get_current_scene().name == "StageThree":
			MasterData.end_time = OS.get_unix_time()
			
			# formula for score calculation:
			# start at 10 points
			# for every additional minute taken to complete the game takes off one point (but the minimum is 1 point)
			# multiply the final one by enemies slain
			var starting_score = 10
			starting_score = starting_score - (int(MasterData.end_time - MasterData.start_time)/60)
			if starting_score < 1:
				starting_score = 1
			var final_score = starting_score * (MasterData.enemies_slain_stage_one + MasterData.enemies_slain_stage_two + MasterData.enemies_slain_stage_three)
			MasterData.final_score = final_score
			
		get_tree().change_scene(target_stage)
