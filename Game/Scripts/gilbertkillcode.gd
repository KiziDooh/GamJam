extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.yup == true:
		if ((Global.get.name == "Bunny") and Input.is_key_pressed(KEY_E)) and Global.knhold == true:
			print("dead")
			Global.gilbertded = true
			$"../../TextureRect".visible = true
			$"../../Glitch Effect".visible = true
			$"gilbert head/Timer".start()
		elif ((Global.get.name == "Bunny") and Input.is_key_pressed(KEY_E)):
			$AudioStreamPlayer3D.play()
