extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.yup = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.whichstick[16] == true:
		$Folage/Stick16.visible = false
	if Global.whichstick[17] == true:
		$Folage/Stick17.visible = false
	if Global.whichstick[18] == true:
		$Folage/Stick18.visible = false
