extends Node



# Called when the node enters the scene tree for the first time.
func _ready():
	$StartButton.grab_focus()

func _physics_process(delta):
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
