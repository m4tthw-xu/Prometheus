extends Node2D

var user_input = ""
var warning_visible = false

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
		if str(PoolByteArray([typed_event.unicode])) == "[0]":
			user_input = user_input.substr(0,user_input.length()-1)
			$PlayerName.text = user_input

func _physics_process(delta):
	$PlayerName.text = user_input
	
	if Input.is_action_pressed("ui_accept"):
		var hi = 2


func _on_Warning_timeout():
	$CharacterWarning.visible = false
	warning_visible = false
	
