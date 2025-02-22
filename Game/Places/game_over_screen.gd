extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	#pass # Replace with function body.
	print(Global.gameover)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.gameover == true:
		$"Campfire area/campfire/GPUParticles3D2".visible == false
		$"Campfire area/campfire/GPUParticles3D2/OmniLight3D".visible == false
		$"Campfire area/campfire/GPUParticles3D2/GPUParticles3D".visible == false
		$"Campfire area/campfire/GPUParticles3D2/GPUParticles3D/OmniLight3D".visible == false
		$"Campfire area/campfire/GPUParticles3D2/GPUParticles3D/GPUParticles3D".visible == false
		$"Campfire area/campfire/GPUParticles3D2/GPUParticles3D/GPUParticles3D/OmniLight3D".visible == false
