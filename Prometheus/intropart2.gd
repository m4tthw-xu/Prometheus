extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var start_mod = false
var mod = 255
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	pass # Replace with function body.

var timer_done = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if timer_done:
		$PlayerComp.position.y = $PlayerComp.position.y + 0.5
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://objective.tscn")


func _on_VideoPlayer_finished():
	get_tree().change_scene("res://Objective.tscn")


func _on_Timer_timeout():
	timer_done = true
	pass # Replace with function body.
