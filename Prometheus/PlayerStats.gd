extends MarginContainer


func _physics_process(delta):
	# only update stats if player on ground so it won't change so frequently
	#if get_parent().get_parent().on_ground == true:
	#	$HBoxContainer/VBoxContainer/Score.text = "Score: " + str(get_parent().get_parent().score)
	#	$HBoxContainer/VBoxContainer/Height.text = "Height: " + str(get_parent().get_parent().height)
	#$HBoxContainer/VBoxContainer/Kills.text = "Kills: " + str(get_parent().get_parent().kills)
	pass
