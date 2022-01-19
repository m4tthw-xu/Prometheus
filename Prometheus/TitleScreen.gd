extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	$StartButton.grab_focus()
	var new_dict = {
		
	}
	# Open a file
	var file = File.new()
	file.open("user://tempPlayerStorage.save", File.WRITE)
	file.store_var(new_dict, true)
	file.close()
	

func _physics_process(delta):
	$Sprite.position.y = $Sprite.position.y + 0.5
	if $StartButton.is_hovered() == true:
		$StartButton.grab_focus()
	if $ExitButton.is_hovered() == true:
		$ExitButton.grab_focus()


func _on_StartButton_pressed():
	get_tree().change_scene("res://Objective.tscn")


func _on_ExitButton_pressed():
	get_tree().quit()


func _on_ControlsButton_pressed():
	get_tree().change_scene("res://Controls.tscn")


func _on_CreditsButton_pressed():
	get_tree().change_scene("res://Credits.tscn")


func _on_LeaderboardButton_pressed():
	get_tree().change_scene("res://Leaderboard.tscn")


func _on_MultiplayerButton_pressed():
	get_tree().change_scene("res://Multiplayer.tscn")
