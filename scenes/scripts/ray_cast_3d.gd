extends RayCast3D

#var var1 = "CAMPFIRE:<Area3D#48972695712>"
#var stick = sTICK eM uP:<Area3D#49425680586>
# Called when the node enters the scene tree for the first time.
func _ready():
	print("super")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_colliding():
		print(get_collider())
		if get_collider() == (sTICK eM uP:<Area3D#49425680586>):
			print("yup")
#$Bunnies/bunny/Bunny$StaticBody3D/CollisionShape3D2$"sTICK eM uP"
