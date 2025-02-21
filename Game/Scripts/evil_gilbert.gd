extends Node3D
var posZ = Global.pz
var posX = Global.px
const SPEED = -10
var xlist = [-5,45,65]
var zlist = [75,55,10]
var which1 = 1
var dirX = 1
var dirZ = 1
var dis = 10
var chase = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(Global.px)
	#print(Global.pz)
	#print(round(position.x))
	#print(round(position.z))
	#print(rotation.y)
	
#supposed to change the rotation idk why its funky like it is

	if ((Global.px <= (position.x+dis)) and (Global.px >= (position.x-dis))) and ((Global.pz <= (position.z+dis)) and (Global.pz >= (position.z-dis))):
		print("rawr")
		chase = true
	if chase == true:
		if position.z < Global.pz:
			position.z -= SPEED * delta
		if position.z > Global.pz:
			position.z += SPEED * delta
		if position.x < Global.px:
			position.x -= SPEED * delta
		if position.x > Global.px:
			position.x += SPEED * delta
		rotation_degrees.y = Global.py
	if (round(position.z) == posZ) and (round(position.x) == posX):
		chase = false
		which1 = randi_range(0,2)
		posZ = zlist[which1]
		posX = xlist[which1]
		position.x = posX
		position.z = posX
		which1 = randi_range(0,2)
	else:
		if (dirX == 2) and (dirZ == 1):
			rotation_degrees.y = 360
		if (dirX == 0) and (dirZ == 1):
			rotation_degrees.y = 45
		if (dirX == 0) and (dirZ == 2):
			rotation_degrees.y = 90 
		if (dirX == 0) and (dirZ == 0):
			rotation_degrees.y = 135
		if (dirX == 1) and (dirZ == 0):
			rotation_degrees.y = 225
		if (dirX == 2) and (dirZ == 0):
			rotation_degrees.y = 180
		if (dirX == 1) and (dirZ == 2):
			rotation_degrees.y = 270
		if (dirX == 1) and (dirZ == 1):
			rotation_degrees.y = 315
			
#checks if reached x and z
		if (round(position.z) == posZ) and (round(position.x) == posX):
		
			posZ = zlist[which1]
			posX = xlist[which1]
			which1 = randi_range(0,2)
		else:
#changes z
			if position.z < posZ:
				position.z -= SPEED * delta
				dirZ = 0
			if position.z > posZ:
				position.z += SPEED * delta
				dirZ = 1
			if round(position.z) == posZ:
				dirZ = 2
#changes x
			if position.x < posX:
				position.x -= SPEED * delta
				dirX = 0
			if position.x > posX:
				position.x += SPEED * delta
				dirX = 1
			if round(position.x) == posX:
				dirX = 2
