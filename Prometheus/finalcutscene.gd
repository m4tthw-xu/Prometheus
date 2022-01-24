extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://GameComplete.tscn")
	


func _on_VideoPlayer_finished():
	get_tree().change_scene("res://GameComplete.tscn")


func _on_Timer_timeout():
	$ColorRect/AnimationPlayer.play("fade")
