extends TextureButton

func _on_pressed():
	Global.isnight = true
	Global.scount = 0
	Global.die = true
	get_tree().change_scene_to_file("res://Game/Places/NightTime.tscn")
	Global.yup = false
	print(Global.die)
