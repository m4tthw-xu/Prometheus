extends Control


func _input(event):
	if event.is_action_pressed("ui_pause") or event.is_action_pressed("ui_cancel"):
		pause()
		
func pause():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state


func _on_Resume_pressed():
	pause()


func _on_Restart_pressed():
	pause()
	# reset all of the stats
	MasterData.health = 100
	MasterData.health_p2 = 100
	MasterData.kills_p1 = 0
	MasterData.kills_p2 = 0
	get_tree().change_scene("res://Multiplayer.tscn")


func _on_Exit_pressed():
	pause()
	get_tree().change_scene("res://TitleScreen.tscn")
