extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.yup == true:
		if (Global.get.name == "sTICK eM uP") and Input.is_key_pressed(KEY_E) and Global.stick == false:
			visible = true
			$"../../../UI/HBoxContainer/TextureRect".texture = load("res://Game/UI/Images/InvStick.png")
			Global.stick = true
	if Input.is_key_pressed(KEY_1) and Global.stick == true:
			visible = false
	if Input.is_key_pressed(KEY_2) and Global.stick == true:
			visible = false
	if Input.is_key_pressed(KEY_3) and Global.stick == true:
			visible = true
