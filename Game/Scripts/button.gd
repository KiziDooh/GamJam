extends TextureButton


func _on_menu_play_pressed():
	$Timer.start()
	Global.blackout = true
	$"Lights out".play()


func _on_pressed():
	$Timer.start()
	print("hiii")
	Global.blackout = true
	$"Lights out".play()
