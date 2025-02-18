extends Node3D

const SPEED = -15
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.z += SPEED * delta
