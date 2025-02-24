extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.gameover == true:
		$"Campfire area/campfire/GPUParticles3D2".emitting = false
		$"Campfire area/campfire/GPUParticles3D2/OmniLight3D".light_energy = 0
		$"Campfire area/campfire/GPUParticles3D2/GPUParticles3D".emitting = false
		$"Campfire area/campfire/GPUParticles3D2/GPUParticles3D/OmniLight3D".light_energy = 0
		$"Campfire area/campfire/GPUParticles3D2/GPUParticles3D/GPUParticles3D".emitting = false
		$"Campfire area/campfire/GPUParticles3D2/GPUParticles3D/GPUParticles3D/OmniLight3D".light_energy = 0
	if Input.is_key_pressed(KEY_ENTER):
		Global.isnight = true
		Global.acount = 0
		Global.die = true
		get_tree().change_scene_to_file("res://Game/Places/NightTime.tscn")
		Global.yup = false
		Global.restart = true
		
