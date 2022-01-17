extends AudioStreamPlayer


func _physics_process(delta):
	print("hi")
	if get_tree().get_current_scene().name.find("Stage") != -1:
		play()
