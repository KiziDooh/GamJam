extends RayCast3D


# Called when the node enters the scene tree for the first time.
func _ready():
	print("super")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_colliding():
		print(get_collider())
