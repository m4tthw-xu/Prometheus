extends Area2D




# Called when the node enters the scene tree for the first time.
func _read():
	pass



func play_animation():
	$AnimatedSprite.play("default")


func _on_AnimatedSprite_animation_finished():
	queue_free()
