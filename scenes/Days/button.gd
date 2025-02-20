extends Button


func _on_pressed():
	$Timer.start()
	Global.blackout = true
	$"Lights out".play()
