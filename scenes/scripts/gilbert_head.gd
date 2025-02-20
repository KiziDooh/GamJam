extends Node3D

func _ready():
	visible = true
	
func _process(delta):
	if Global.gilbertded == true:
		visible = false

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/Days/NightTime.tscn")
	Global.yup = false
