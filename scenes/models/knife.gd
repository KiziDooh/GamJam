extends Node3D

var Knife = false
# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		if Knife == true:
			visible = true
