extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.blackout == true:
		#turns everything off
		$"Campfire area/Rock3".visible = false
		$"Campfire area/Rock".visible = false
		$"Campfire area/Rock2".visible = false
		$"Campfire area/stumpid5".visible = false
		$"Campfire area/tree27".visible = false
		$"Campfire area/Log".visible = false
		$"Campfire area/bigtree10".visible = false
		$"Campfire area/stumpid".visible = false
		$"Campfire area/campfire".visible = false
		$"Campfire area/tree25".visible = false
		$"Campfire area/tree26".visible = false
		$"Campfire area/playbox".visible = false
		$"Campfire area/Grass".visible = false
		$MenuPlay.visible = false
		#turns on black box
		$"Dark mode/CSGBox3D".visible = true
		$"Dark mode/CSGBox3D5".visible = true
		$"Dark mode/CSGBox3D6".visible = true
		$"Dark mode/CSGBox3D2".visible = true
		$"Dark mode/CSGBox3D3".visible = true
		$"Dark mode/CSGBox3D4".visible = true
		$"Dark mode/Text_003".visible = true
		$"Dark mode/Text_004".visible = true
	


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/Days/DayTime.tscn")
	Global.yup = false
