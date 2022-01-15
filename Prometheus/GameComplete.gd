extends Node2D

var user_input = ""
var warning_visible = false
var too_short_warning_visible = false

func _ready():
	$EnemiesSlain.text = "Total Enemies Slain: " + str(MasterData.enemies_slain_stage_one + MasterData.enemies_slain_stage_two + MasterData.enemies_slain_stage_three)
	$FinalScore.text = "Final Score: " + str(MasterData.final_score)
	
	$CharacterWarning.visible = false
	$MinCharacterWarning.visible = false

func _unhandled_input (event:InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		var typed_event = event as InputEventKey
		var key_typed = PoolByteArray([typed_event.unicode]).get_string_from_utf8()
		if user_input.length() >= 20 and warning_visible == false:
			# gives a warning if the user's username is over 20 characters
			# doesn't give warning if the currnt input is a backspace
			if str(PoolByteArray([typed_event.unicode])).find("[0]") != 0:
				warning_visible = true
				$CharacterWarning.visible = true
				$Warning.start()
		if user_input.length() < 20:
			user_input = user_input + key_typed
			$PlayerName.text = user_input

func _physics_process(delta):
	$PlayerName.text = user_input
	
	if Input.is_action_just_pressed("ui_backspace"):
		user_input = user_input.substr(0,user_input.length()-1)
		$PlayerName.text = user_input
	
	if Input.is_action_just_pressed("ui_enter") and user_input.length() == 0:
		if too_short_warning_visible == false:
			$MinCharacterWarning.visible = true
			$TooShortWarning.start()
			too_short_warning_visible = true
	
	if Input.is_action_just_pressed("ui_enter") and user_input.length() > 0:
		MasterData.player_name = user_input
		
		# saves the new player information into the leaderboard
		# format for saving player information
		# ####
		# {name}
		# {start_time}
		# {end_time}
		# {enemies_slain}
		
		# load in old information
		var file = File.new()
		file.open("res://leaderboard.txt", File.READ)
		var old_text = file.get_as_text()
		file.close()
		
		# add in new data
		var new_text = old_text + "\n####" + "\n" + MasterData.player_name + "\n" + str(MasterData.start_time) + "\n" +  str(MasterData.end_time) + "\n" + str(MasterData.enemies_slain_stage_one + MasterData.enemies_slain_stage_two + MasterData.enemies_slain_stage_three)
		
		var my_file = File.new()
		my_file.open("res://leaderboard.txt", File.WRITE)
		assert(my_file.is_open())
		my_file.store_string(new_text)
		my_file.close()
		
		
		get_tree().change_scene("res://Leaderboard.tscn")

func _on_Warning_timeout():
	$CharacterWarning.visible = false
	warning_visible = false
	


func _on_Timer_timeout():
	$MinCharacterWarning.visible = false
	too_short_warning_visible = false
