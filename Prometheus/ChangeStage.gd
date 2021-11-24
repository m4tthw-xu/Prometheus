extends Area2D

export(String, FILE, "*.tscn") var target_stage


func _ready():
	pass


# changes stage of current scene when player enters the area
func _on_ChangeStage_body_entered(body):
	if "Player" in body.name:
		get_tree().change_scene(target_stage)
