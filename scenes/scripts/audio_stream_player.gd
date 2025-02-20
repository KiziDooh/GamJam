extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pitch_scale = 0.95

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.gilbertded == true:
		pitch_scale = 0.3
	if Global.knhold == true and Global.gilbertded == false:
		pitch_scale = 0.65
