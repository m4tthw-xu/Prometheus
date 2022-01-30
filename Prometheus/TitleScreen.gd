extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	$StartButton.grab_focus()
	$AudioStreamPlayer2D.play()
	var new_dict = {
		
	}
	# Open a file
	var file = File.new()
	file.open("user://tempPlayerStorage.save", File.WRITE)
	file.store_var(new_dict, true)
	file.close()
	

var speed = 0.25
func _set_speed():
	$Sprite.position.y = $Sprite.position.y + speed

func _physics_process(delta):
	
	if !sfxPlaying and startTimerPlayed:
		get_tree().change_scene("res://intropart1.tscn")
	
	if $Sprite.position.y <= -1792:
		speed = 0.25
	elif $Sprite.position.y >= 1900:
		speed = -0.25
		
	_set_speed()
	
	if $StartButton.is_hovered() == true:
		$StartButton.grab_focus()
	if $ExitButton.is_hovered() == true:
		$ExitButton.grab_focus()

var sfxPlaying = false
var startTimerPlayed = false

func _on_StartButton_pressed():
	$StartButtonSFX.play()
	sfxPlaying = true
	$StartButtonTimer.start()


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


func _on_StartButtonTimer_timeout():
	startTimerPlayed = true
	sfxPlaying = false
