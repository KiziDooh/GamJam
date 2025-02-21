extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.yup == true:
		if (Global.get.name == "FlashLight") and Input.is_key_pressed(KEY_E) and Global.flashlight == false:
			visible = true
			Global.flashlight = true
			$"../../../UI/HBoxContainer/TextureRect2".texture = load("res://Game/UI/Images/InvFlash.png")
	if Input.is_key_pressed(KEY_1) and Global.flashlight == true:
		visible = false
	if Input.is_key_pressed(KEY_2) and Global.flashlight == true:
		visible = true
	if Input.is_key_pressed(KEY_3) and Global.flashlight == true:
		visible = false
