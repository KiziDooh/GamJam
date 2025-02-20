extends Button

func _on_pressed():
	get_tree().change_scene_to_file("res://Game/Places/NightTime.tscn")
	Global.yup = false
