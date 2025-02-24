extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var cooldown: float = 0
var cooldown2: float = 0
var silly = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Global.gilbertded == true:
		if cooldown >= 0:
			cooldown -= delta
		elif cooldown <= 0:
			$"../../TextureRect".visible = true
			cooldown = 0.2
		if cooldown2 >= 0:
			cooldown2 -= delta
		elif cooldown2 <= 0:
			$"../../TextureRect".visible = false
			cooldown2 = 0.3
			
func _process(delta):
	if Global.yup == true:
		if ((Global.get.name == "Bunny") and Input.is_key_pressed(KEY_E)) and Global.knhold == true and Global.active == 1:
			print("dead")
			Global.gilbertded = true
			$"../../Glitch Effect".visible = true
			$"gilbert head/Timer".start()
		elif (Global.get.name == "Bunny"):
			if silly == 0 and Input.is_key_pressed(KEY_E):
				$AudioStreamPlayer3D2.play()
				$Timer.start()
			if silly == 1 and Input.is_key_pressed(KEY_E):
				$AudioStreamPlayer3D3.play()
				$Timer.start()
			if silly == 2 and Input.is_key_pressed(KEY_E):
				$AudioStreamPlayer3D5.play()
				$Timer.start()
			if silly == 3 and Input.is_key_pressed(KEY_E):
				$AudioStreamPlayer3D4.play()
				$Timer.start()
			if silly == 4 and Input.is_key_pressed(KEY_E):
				$AudioStreamPlayer3D6.play()
				$Timer.start()
			if silly == 5 and Input.is_key_pressed(KEY_E):
				$AudioStreamPlayer3D.play()


func _on_timer_timeout():
	silly = silly + 1
