extends Node3D
var posZ = 0
var posX = 0
const SPEED = -10
var xlist = [-5,45,65]
var zlist = [75,55,10]
var which1 = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(round(position.x))
	print(round(position.z))

#checks if reached x and z
	if (round(position.z) == posZ) and (round(position.x) == posX):
		posZ = zlist[which1]
		posX = xlist[which1]
	else:
#changes z
		if position.z < posZ:
			position.z -= SPEED * delta
		if position.z > posZ:
			position.z += SPEED * delta
#changes x
		if position.x < posX:
			position.x -= SPEED * delta
		if position.x > posX:
			position.x += SPEED * delta
