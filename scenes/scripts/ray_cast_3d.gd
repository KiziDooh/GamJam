extends RayCast3D

#var var1 = "CAMPFIRE:<Area3D#48972695712>"
var var2 = "sda"
# Called when the node enters the scene tree for the first time.
func _ready():
	print("super")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_colliding():
		print(get_collider())
	#	if type_string(var2) == type_string(var1):
			#print("yup")
