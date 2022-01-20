extends Area2D

var collected = false

func _on_Spear_body_entered(body):
	if collected == false && MasterData.spear_charges < 4:
		$AudioStreamPlayer2D.play()
		MasterData.spear_charges = MasterData.spear_charges + 1
		$Spearitem.set_texture(null)
		collected = true
