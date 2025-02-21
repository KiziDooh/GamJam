extends Node3D

var Knife = false
# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.yup == true:
		if (Global.get.name == "knife") and Input.is_key_pressed(KEY_E) and Global.knhold == false:
			visible = true
			$"../../../UI/HBoxContainer/TextureRect".texture = load("res://Game/UI/Images/InvKnife.png")
			Global.knhold = true
	if Input.is_key_pressed(KEY_1) and Global.knhold == true:
			visible = true
	if Input.is_key_pressed(KEY_2) and Global.knhold == true:
			visible = false
