extends Node3D

func _ready():
	visible = true
	
func _process(delta):
	if Global.gilbertded == true:
		visible = false
