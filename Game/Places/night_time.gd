extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.isnight = true
	$"Anomlies/gilberts head".visible = false
	$"Anomlies/gilberts head/GPUParticles3D2".amount = 0
	Global.flashlight = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.Anomlies[0] == true:
		$Anomlies/freddyfastbear.visible = false
		Global.camp = true
	if Global.Anomlies[1] == true:
		$"Anomlies/toy car".visible = false
		Global.camp = true
	if Global.Anomlies[2] == true:
		$"Anomlies/gilberts head".visible = false
		Global.camp = true
	if Global.Anomlies[3] == true:
		$Anomlies/ducky.visible = false
		Global.camp = true
	if Global.Anomlies[4] == true:
		$Anomlies/cupcake.visible = false
		Global.camp = true
	if Global.Anomlies[5] == true:
		$Anomlies/sinige.visible = false
		Global.camp = true
	if Global.Anomlies[6] == true:
		$"Anomlies/8ballin".visible = false
		Global.camp = true
	if Global.Anomlies[7] == true:
		$Anomlies/skullforglitch.visible = false
		Global.camp = true
		
	
	
	if Global.acount == 1:
		$"cage/sleeping gilly".visible = false
		$"Bunnies/evil gilbert".visible = true
	if Global.acount == 7 and Global.Anomlies[2] == false:
		$"Anomlies/gilberts head".visible = true
		$"Anomlies/toy car/GPUParticles3D".amount = 20
		$"Bunnies/evil gilbert".visible = false
	if Global.acount == 8:
		get_tree().change_scene_to_file("res://Game/Places/Credits.tscn")
		Global.yup = false
	
	
	
	if Global.whichstick[0] == true:
		$sticks/Stick.visible = false
		Global.camp = true
	if Global.whichstick[1] == true:
		$sticks/Stick1.visible = false
		Global.camp = true
	if Global.whichstick[2] == true:
		$sticks/Stick2.visible = false
		Global.camp = true
	if Global.whichstick[3] == true:
		$sticks/Stick3.visible = false
		Global.camp = true
	if Global.whichstick[4] == true:
		$sticks/Stick4.visible = false
		Global.camp = true
	if Global.whichstick[5] == true:
		$sticks/Stick5.visible = false
		Global.camp = true
	if Global.whichstick[6] == true:
		$sticks/Stick6.visible = false
		Global.camp = true
	if Global.whichstick[7] == true:
		$sticks/Stick7.visible = false
		Global.camp = true
	if Global.whichstick[8] == true:
		$sticks/Stick8.visible = false
		Global.camp = true
	if Global.whichstick[9] == true:
		$sticks/Stick9.visible = false
		Global.camp = true
	if Global.whichstick[10] == true:
		$sticks/Stick10.visible = false
		Global.camp = true
	if Global.whichstick[11] == true:
		$sticks/Stick11.visible = false
		Global.camp = true
	if Global.whichstick[12] == true:
		$sticks/Stick12.visible = false
		Global.camp = true
	if Global.whichstick[13] == true:
		$sticks/Stick13.visible = false
		Global.camp = true
	if Global.whichstick[14] == true:
		$sticks/Stick14.visible = false
		Global.camp = true
	if Global.whichstick[15] == true:
		$sticks/Stick15.visible = false
		Global.camp = true
