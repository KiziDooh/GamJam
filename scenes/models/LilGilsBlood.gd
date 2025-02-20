extends GPUParticles3D

func _ready():
	visible = false
func _process(delta):
	if Global.gilbertded == true:
		visible = true
