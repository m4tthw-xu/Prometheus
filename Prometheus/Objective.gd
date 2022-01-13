extends Node2D


# this is simply the instructions page
# the user is brought to the first level after 5 seconds or the user presses the space bar

func _physics_process(delta):
	
	if Input.is_action_pressed("ui_accept"):
		get_tree().change_scene("res://StageOne.tscn")

# timer to automatically move to the first level after 5 seconds
func _on_AutoNext_timeout():
	get_tree().change_scene("res://StageOne.tscn")
