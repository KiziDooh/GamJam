extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.isnight = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.Anomlies[0] == true:
		$Anomlies/freddyfastbear.visible = false
	if Global.Anomlies[1] == true:
		$"Anomlies/toy car".visible = false
	if Global.Anomlies[2] == true:
		$"Anomlies/gilberts head".visible = false
	if Global.Anomlies[3] == true:
		$Anomlies/ducky.visible = false
	if Global.Anomlies[4] == true:
		$Anomlies/cupcake.visible = false
	if Global.Anomlies[5] == true:
		$Anomlies/sinige.visible = false
	if Global.Anomlies[6] == true:
		$"Anomlies/8ballin".visible = false
	if Global.Anomlies[7] == true:
		$Anomlies/skullforglitch.visible = false
		
	if Global.acount == 8:
		get_tree().change_scene_to_file("res://Game/Places/Credits.tscn")
		Global.yup = false
	
	
	
	
