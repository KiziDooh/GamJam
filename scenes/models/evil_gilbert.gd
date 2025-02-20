extends Node3D
var posZ = 0
var posX = 0
const SPEED = -10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.z < posZ:
		position.z -= SPEED * delta
	if position.z > posZ:
		position.z += SPEED * delta
	if position.x < posX:
		position.x -= SPEED * delta
	if position.x > posX:
		position.x += SPEED * delta
