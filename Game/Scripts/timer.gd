extends Timer

func _on_timeout():
	print("howdy")
	get_tree().change_scene_to_file("res://scenes/Days/DayTime.tscn")
	Global.yup = false
