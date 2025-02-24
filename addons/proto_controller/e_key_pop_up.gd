extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.yup == true:
		if Global.get.name == "CAMPFIRE":
			if Global.Anomlies[0] == true and Global.camp == true:
				visible = true
			if Global.Anomlies[1] == true and Global.camp == true:
				visible = true
			if Global.Anomlies[2] == true and Global.camp == true:
				visible = true
			if Global.Anomlies[3] == true and Global.camp == true:
				visible = true
			if Global.Anomlies[4] == true and Global.camp == true:
				visible = true
			if Global.Anomlies[5] == true and Global.camp == true:
				visible = true
			if Global.Anomlies[6] == true and Global.camp == true:
				visible = true
			if Global.Anomlies[7] == true and Global.camp == true:
				visible = true
			if Global.whichstick[0] == true and Global.camp == true:
				visible = true
			if Global.whichstick[1] == true and Global.camp == true:
				visible = true
			if Global.whichstick[2] == true and Global.camp == true:
				visible = true
			if Global.whichstick[3] == true and Global.camp == true:
				visible = true
			if Global.whichstick[4] == true and Global.camp == true:
				visible = true
			if Global.whichstick[5] == true and Global.camp == true:
				visible = true
			if Global.whichstick[6] == true and Global.camp == true:
				visible = true
			if Global.whichstick[7] == true and Global.camp == true:
				visible = true
			if Global.whichstick[8] == true and Global.camp == true:
				visible = true
			if Global.whichstick[9] == true and Global.camp == true:
				visible = true
			if Global.whichstick[11] == true and Global.camp == true:
				visible = true
			if Global.whichstick[12] == true and Global.camp == true:
				visible = true
			if Global.whichstick[13] == true and Global.camp == true:
				visible = true
			if Global.whichstick[14] == true and Global.camp == true:
				visible = true
			if Global.whichstick[15] == true and Global.camp == true:
				visible = true
			if Global.whichstick[16] == true and Global.camp == true:
				visible = true
			if Global.whichstick[17] == true and Global.camp == true:
				visible = true
			if Global.whichstick[18] == true and Global.camp == true:
				visible = true
		if Global.get.name == "knife" and Global.knhold == false:
			visible = true
		if Global.get.name == "FlashLight" and Global.flashlight == false:
			visible = true
		if Global.get.name == "Anamlee1" and Global.hold == false and Global.Anomlies[0] == false:
			visible = true
		if Global.get.name == "Anamlee2" and Global.hold == false and Global.Anomlies[1] == false:
			visible = true	
		if Global.get.name == "Anamlee3" and Global.hold == false and Global.Anomlies[2] == false and Global.acount == 7:
			visible = true
		if Global.get.name == "Anamlee4" and Global.hold == false and Global.Anomlies[3] == false:
			visible = true
		if Global.get.name == "Anamlee5" and Global.hold == false and Global.Anomlies[4] == false:
			visible = true
		if Global.get.name == "Anamlee6" and Global.hold == false and Global.Anomlies[5] == false:
			visible = true
		if Global.get.name == "Anamlee7" and Global.hold == false and Global.Anomlies[6] == false:
			visible = true
		if Global.get.name == "Anamlee8" and Global.hold == false and Global.Anomlies[7] == false:
			visible = true
		if Global.get.name == "sx" and Global.hold == false and Global.whichstick[0] == false:
			visible = true
		if Global.get.name == "s1" and Global.hold == false and Global.whichstick[1] == false:
			visible = true
		if Global.get.name == "s2" and Global.hold == false and Global.whichstick[2] == false:
			visible = true
		if Global.get.name == "s3" and Global.hold == false and Global.whichstick[3] == false:
			visible = true
		if Global.get.name == "s4" and Global.hold == false and Global.whichstick[4] == false:
			visible = true
		if Global.get.name == "s5" and Global.hold == false and Global.whichstick[5] == false:
			visible = true
		if Global.get.name == "s6" and Global.hold == false and Global.whichstick[6] == false:
			visible = true
		if Global.get.name == "s7" and Global.hold == false and Global.whichstick[7] == false:
			visible = true
		if Global.get.name == "s8" and Global.hold == false and Global.whichstick[8] == false:
			visible = true
		if Global.get.name == "s9" and Global.hold == false and Global.whichstick[9] == false:
			visible = true
		if Global.get.name == "s10" and Global.hold == false and Global.whichstick[10] == false:
			visible = true
		if Global.get.name == "s11" and Global.hold == false and Global.whichstick[11] == false:
			visible = true
		if Global.get.name == "s12" and Global.hold == false and Global.whichstick[12] == false:
			visible = true
		if Global.get.name == "s13" and Global.hold == false and Global.whichstick[13] == false:
			visible = true
		if Global.get.name == "s14" and Global.hold == false and Global.whichstick[14] == false:
			visible = true
		if Global.get.name == "s15" and Global.hold == false and Global.whichstick[15] == false:
			visible = true
		if Global.get.name == "s16" and Global.hold == false and Global.whichstick[16] == false:
			visible = true
		if Global.get.name == "s17" and Global.hold == false and Global.whichstick[17] == false:
			visible = true
		if Global.get.name == "s18" and Global.hold == false and Global.whichstick[18] == false:
			visible = true
		if Global.get.name == "Bunny":
			visible = true
	else:
		visible = false
