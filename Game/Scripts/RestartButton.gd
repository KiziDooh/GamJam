extends TextureButton

func _on_pressed():
	Global.isnight = true
	Global.acount = 0
	Global.die = true
	get_tree().change_scene_to_file("res://Game/Places/NightTime.tscn")
	get_tree().reload_current_scene()
	Global.yup = false
