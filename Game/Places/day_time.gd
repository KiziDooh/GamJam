extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.whichstick[0] == true:
		$Folage/Stick.visible = false
	if Global.whichstick[1] == true:
		$Folage/Stick1.visible = false
	if Global.whichstick[2] == true:
		$Folage/Stick2.visible = false
