extends Node2D

var filePath:String
var loadedFile:File = File.new()
var velocity = Vector2()
var y = 0

#simply adding a filler

var counter = 0

func _physics_process(delta):
	
	if Input.is_action_pressed("ui_select"):
		get_tree().change_scene("res://TitleScreen.tscn")
	
	# array that holds the text
	var array = []
	
	# receive the text file that contains the leaderboarrd functions
	loadedFile.open("res://leaderboard.txt", File.READ)
	
	# load the text into the script
	var text = loadedFile.get_as_text()
	var last_line_break = 0
	
	# close the file for resource management and best practices
	loadedFile.close()
	
	# splits the input text into an array
	array = text.split("\n")
	
	# removes the first 3 lines of filler information
	array.remove(0)
	array.remove(0)
	array.remove(0)
	array.remove(0)
	
	# adds the information into a dictionary
	var data = []
	for i in range(0,array.size(),5):
		var new_dict = {}
		new_dict["name"] = array[i+1]
		new_dict["time_elapsed"] = str((int(array[i+3]) - int(array[i+2]))/60)
		new_dict["enemies_slain"] = array[i+4]
		
		# adds the final score
		# formula for score calculation:
		# start at 10 points
		# for every additional minute taken to complete the game takes off one point (but the minimum is 1 point)
		# multiply the final one by enemies slain
		var starting_score = 10
		starting_score = starting_score - int(new_dict["time_elapsed"])
		if starting_score < 1:
			starting_score = 1
		var final_score = starting_score * int(new_dict["enemies_slain"])
		
		new_dict["final_score"] = final_score
		
		data.append(new_dict)
	
	var sorted_data = []
	# sorts the players by final_score and then aadds the sorted players into sorted_data
	for obj in data:
		var inserted = false
		if sorted_data.size() > 0:
			for i in sorted_data.size():
				if obj["final_score"] > sorted_data[i]["final_score"] and inserted == false:
					sorted_data.insert(i, obj)
					inserted = true
		if inserted == false:
			sorted_data.append(obj)
	
	# resets all of the placeholders
	$ColorRect/Player1.text  = ""
	$ColorRect/Player2.text  = ""
	$ColorRect/Player3.text  = ""
	
	# places the sorted information onto the screen
	if sorted_data.size() > 0:
		$ColorRect/Player1.text = "1st: " + sorted_data[0]["name"] + " - " + str(sorted_data[0]["final_score"]) + " points"
	if sorted_data.size() > 1:
		$ColorRect/Player2.text = "2nd: " + sorted_data[1]["name"] + " - " + str(sorted_data[1]["final_score"]) + " points"
	if sorted_data.size() > 2:
		$ColorRect/Player3.text = "3rd: " + sorted_data[2]["name"] + " - " + str(sorted_data[2]["final_score"]) + " points"
	
	#velocity.y += 5
	if $ColorRect/Sprite.position.y >= 300:
		$ColorRect/Sprite.position.y = -244
	$ColorRect/Sprite.position.y +=  0.13# Sets the position of Y to 20
