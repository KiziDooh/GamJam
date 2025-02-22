extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.blackout == true:
		#turns everything off
		$MeshInstance3D.visible = false
		$"Campfire area/stumpid3".visible = false
		$"Campfire area/Log".visible = false
		$"Campfire area/stumpid".visible = false
		$"Campfire area/Rock".visible = false
		$"Campfire area/Rock3".visible = false
		$"Campfire area/Rock2".visible = false
		$"Campfire area/campfire".visible = false
		$"Campfire area/tree25".visible = false
		$"Campfire area/tree26".visible = false
		$"Campfire area/stumpid5".visible = false
		$"Campfire area/tree27".visible = false
		$"Campfire area/bigtree10".visible = false
		$"Campfire area/Grass".visible = false
		$"Campfire area/bigtree11".visible = false
		$"Campfire area/bigtree12".visible = false
		$"Campfire area/bigtree13".visible = false
		$"Campfire area/bigtree14".visible = false
		$"Campfire area/bigtree15".visible = false
		$"Campfire area/bigtree16".visible = false
		$"Campfire area/bigtree17".visible = false
		$"Campfire area/bigtree18".visible = false
		$"Campfire area/bigtree19".visible = false
		$"Campfire area/bigtree20".visible = false
		$"Campfire area/bigtree21".visible = false
		$"Campfire area/bigtree22".visible = false
		$"Campfire area/bigtree23".visible = false
		$"Campfire area/bigtree24".visible = false
		$"Campfire area/bigtree25".visible = false
		$"Campfire area/bigtree26".visible = false
		$"Campfire area/bigtree27".visible = false
		$"Campfire area/bigtree28".visible = false
		$"Campfire area/bigtree29".visible = false
		$"Campfire area/bigtree30".visible = false
		$"Campfire area/tree28".visible = false
		$"Campfire area/tree29".visible = false
		$"Campfire area/tree30".visible = false
		$"Campfire area/tree31".visible = false
		$"Campfire area/tree32".visible = false
		$"Campfire area/tree33".visible = false
		$"Campfire area/tree34".visible = false
		$"Campfire area/tree35".visible = false
		$"Campfire area/tree36".visible = false
		$"Campfire area/tree37".visible = false
		$"Campfire area/tree38".visible = false
		$"Campfire area/tree39".visible = false
		$"Campfire area/tree40".visible = false
		$"Campfire area/tree41".visible = false
		$"Campfire area/tree42".visible = false
		$"Campfire area/bigtree31".visible = false
		$"Campfire area/bigtree32".visible = false
		$"Campfire area/bigtree33".visible = false
		$"Campfire area/bigtree34".visible = false
		$"Campfire area/bigtree35".visible = false
		$"Campfire area/tree43".visible = false
		$"Campfire area/bigtree36".visible = false
		$"Campfire area/bigtree37".visible = false
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
		$"Glitch Effect".visible = true

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Game/Places/DayTime.tscn")
	Global.yup = false
