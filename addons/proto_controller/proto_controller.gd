# ProtoController v1.0 by Brackeys
# CC0 License
# Intended for rapid prototyping of first-person games.
# Happy prototyping!

extends CharacterBody3D

class_name Player

## Can we move around?w
@export var can_move : bool = true
## Are we affected by gravity?
@export var has_gravity : bool = true
## Can we press to jump?
@export var can_jump : bool = true
## Can we hold to run?
@export var can_sprint : bool = false
## Can we press to enter freefly mode (noclip)?
@export var can_freefly : bool = false

@export_group("Speeds")
## Look around rotation speed.
@export var look_speed : float = 0.002
## Normal speed.
@export var base_speed : float = 7.0
## Speed of jump.
@export var jump_velocity : float = 4.5
## How fast do we run?
@export var sprint_speed : float = 12.0
## How fast do we freefly?
@export var freefly_speed : float = 25.0

@export_group("Input Actions")
## Name of Input Action to move Left.
@export var input_left : String = "ui_left"
## Name of Input Action to move Right.
@export var input_right : String = "ui_right"
## Name of Input Action to move Forward.
@export var input_forward : String = "ui_up"
## Name of Input Action to move Backward.
@export var input_back : String = "ui_down"
## Name of Input Action to Jump.
@export var input_jump : String = "ui_accept"
## Name of Input Action to Sprint.
@export var input_sprint : String = "sprint"
## Name of Input Action to toggle freefly mode.
@export var input_freefly : String = "freefly"

var max_stamina: int = 300
var current_stamina = max_stamina

var cooldown: float = 0.3

var mouse_captured : bool = false
var look_rotation : Vector2
var move_speed : float = 0.0
var freeflying : bool = false

## IMPORTANT REFERENCES
@onready var head: Node3D = $Head
@onready var collider: CollisionShape3D = $Collider


func _ready() -> void:
	check_input_mappings()
	look_rotation.y = rotation.y
	look_rotation.x = head.rotation.x
	if Global.knhold == true:
		$UI/HBoxContainer/TextureRect.texture = load("res://Game/UI/Images/InvKnife.png")
	if Global.flashlight == true:
		$UI/HBoxContainer/TextureRect2.texture = load("res://Game/UI/Images/InvFlash.png")
#	if Global.stick == true:
	#	$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/Inv3E.png")



func _unhandled_input(event: InputEvent) -> void:
	# Mouse capturing
	#if Global.gameover == false:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		capture_mouse()
	if Input.is_key_pressed(KEY_ESCAPE):
		release_mouse()

		
	# Look around
	if mouse_captured and event is InputEventMouseMotion:
		rotate_look(event.relative)
	
	# Toggle freefly mode
	if can_freefly and Input.is_action_just_pressed(input_freefly):
		if not freeflying:
			enable_freefly()
		else:
			disable_freefly()

func _physics_process(delta: float) -> void:
	if cooldown >= 0:
		cooldown -= delta
	
	if get_tree().current_scene.name == "Dark Time":
		$Counter.visible = true
	if Global.flashlight == true and Global.active == 2:	
		if Input.is_key_pressed(KEY_F) and $Head/Camera3D/SpotLight3D.visible == true:
			if cooldown <= 0:
				$Head/Camera3D/SpotLight3D.visible = false
				$Head/Camera3D/SpotLight3D/FlashOnSound2.play()
				cooldown = 0.3
				
		elif Input.is_key_pressed(KEY_F) and $Head/Camera3D/SpotLight3D.visible == false:
			if cooldown <= 0:
				$Head/Camera3D/SpotLight3D.visible = true
				$Head/Camera3D/SpotLight3D/FlashOnSound.play()
				cooldown = 0.3

		
	# If freeflying, handle freefly and nothing else
	if can_freefly and freeflying:
		var input_dir := Input.get_vector(input_left, input_right, input_forward, input_back)
		var motion := (head.global_basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		motion *= freefly_speed * delta
		move_and_collide(motion)
		return
	
	# Apply gravity to velocity
	if has_gravity:
		if not is_on_floor():
			velocity += get_gravity() * delta

	# Apply jumping
	if can_jump:
		if Input.is_action_just_pressed(input_jump) and is_on_floor():
			velocity.y = jump_velocity
			$WalkingSound.playing = false
			$WalkingSound2.playing = false
			

	# Modify speed based on sprinting
	if current_stamina >= 300:
		can_sprint = true
		
	if can_sprint and Input.is_action_pressed(input_sprint):
		if current_stamina > 0:
			move_speed = sprint_speed
			current_stamina = current_stamina - 1.5
			$"UI/Stamina Bar".value = current_stamina
		else:
			move_speed = base_speed	
			can_sprint = false
	else:
		move_speed = base_speed
		
	if ! Input.is_action_pressed(input_sprint):
		if current_stamina < 300:
			current_stamina = current_stamina + 1
			$"UI/Stamina Bar".value = current_stamina

	# Apply desired movement to velocity
	if can_move:
		var input_dir := Input.get_vector(input_left, input_right, input_forward, input_back)
		var move_dir := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if move_dir:
			if $WalkingSound2.playing == false and is_on_floor():
				if Input.is_action_pressed(input_sprint) and can_sprint == true:
					$WalkingSound.playing = false
					$WalkingSound2.set_pitch_scale(randf_range(1, 1.5))
					$WalkingSound2.play()
				else:
					if $WalkingSound.playing == false and is_on_floor():
						$WalkingSound2.playing = false
						$WalkingSound.set_pitch_scale(randf_range(1, 1.5))
						$WalkingSound.play()
			velocity.x = move_dir.x * move_speed
			velocity.z = move_dir.z * move_speed
		else:
			$WalkingSound.playing = false
			$WalkingSound2.playing = false
			velocity.x = move_toward(velocity.x, 0, move_speed)
			velocity.z = move_toward(velocity.z, 0, move_speed)
	else:
		velocity.x = 0
		velocity.y = 0
	
	# Use velocity to actually move
	move_and_slide()


## Rotate us to look around.
## Base of controller rotates around y (left/right). Head rotates around x (up/down).
## Modifies look_rotation based on rot_input, then resets basis and rotates by look_rotation.
func rotate_look(rot_input : Vector2):
	look_rotation.x -= rot_input.y * look_speed
	look_rotation.x = clamp(look_rotation.x, deg_to_rad(-85), deg_to_rad(85))
	look_rotation.y -= rot_input.x * look_speed
	transform.basis = Basis()
	rotate_y(look_rotation.y)
	head.transform.basis = Basis()
	head.rotate_x(look_rotation.x)


func enable_freefly():
	collider.disabled = true
	freeflying = true
	velocity = Vector3.ZERO

func disable_freefly():
	collider.disabled = false
	freeflying = false


func capture_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_captured = true


func release_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_captured = false


## Checks if some Input Actions haven't been created.
## Disables functionality accordingly.
func check_input_mappings():
	if can_move and not InputMap.has_action(input_left):
		push_error("Movement disabled. No InputAction found for input_left: " + input_left)
		can_move = false
	if can_move and not InputMap.has_action(input_right):
		push_error("Movement disabled. No InputAction found for input_right: " + input_right)
		can_move = false
	if can_move and not InputMap.has_action(input_forward):
		push_error("Movement disabled. No InputAction found for input_forward: " + input_forward)
		can_move = false
	if can_move and not InputMap.has_action(input_back):
		push_error("Movement disabled. No InputAction found for input_back: " + input_back)
		can_move = false
	if can_jump and not InputMap.has_action(input_jump):
		push_error("Jumping disabled. No InputAction found for input_jump: " + input_jump)
		can_jump = false
	if can_sprint and not InputMap.has_action(input_sprint):
		push_error("Sprinting disabled. No InputAction found for input_sprint: " + input_sprint)
		can_sprint = false
	if can_freefly and not InputMap.has_action(input_freefly):
		push_error("Freefly disabled. No InputAction found for input_freefly: " + input_freefly)
		can_freefly = false


func _on_health_health_depleated():
	print("You Died") # Replace with function body.
	queue_free()
	get_tree().change_scene_to_file("res://Game/Places/scarytime.tscn")
	Global.yup = false
func _process(delta):
	Global.pz = position.z
	Global.px = position.x
	
	
	
	
	if Global.yup == true:
		if (Global.get.name == "Anamlee1") and Input.is_key_pressed(KEY_E) and Global.Anomlies[0] == false and Global.hold == false and Global.stick == false:
			$Head/Camera3D/freddyfastbear.visible = true
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/InvAnamoly.png")
			Global.Anomlies[0] = true
			Global.hold = true
			Global.active = 3
		if (Global.get.name == "Anamlee2") and Input.is_key_pressed(KEY_E) and Global.Anomlies[1] == false and Global.hold == false and Global.stick == false:
			$"Head/Camera3D/toy car".visible = true
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/InvAnamoly.png")
			Global.Anomlies[1] = true
			Global.hold = true
			Global.active = 3
		if (Global.get.name == "Anamlee3") and Input.is_key_pressed(KEY_E) and Global.Anomlies[2] == false and Global.hold == false and Global.stick == false:
			$"Head/Camera3D/gilberts head".visible = true
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/InvAnamoly.png")
			Global.Anomlies[2] = true
			Global.hold = true
			Global.active = 3
		if (Global.get.name == "Anamlee4") and Input.is_key_pressed(KEY_E) and Global.Anomlies[3] == false and Global.hold == false and Global.stick == false:
			$Head/Camera3D/ducky.visible = true
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/InvAnamoly.png")
			Global.Anomlies[3] = true
			Global.hold = true
			Global.active = 3
		if (Global.get.name == "Anamlee5") and Input.is_key_pressed(KEY_E) and Global.Anomlies[4] == false and Global.hold == false and Global.stick == false:
			$Head/Camera3D/cupcake.visible = true
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/InvAnamoly.png")
			Global.Anomlies[4] = true
			Global.hold = true
			Global.active = 3
		if (Global.get.name == "Anamlee6") and Input.is_key_pressed(KEY_E) and Global.Anomlies[5] == false and Global.hold == false and Global.stick == false:
			$Head/Camera3D/sinige.visible = true
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/InvAnamoly.png")
			Global.Anomlies[5] = true
			Global.hold = true
			Global.active = 3
		if (Global.get.name == "Anamlee7") and Input.is_key_pressed(KEY_E) and Global.Anomlies[6] == false and Global.hold == false and Global.stick == false:
			$"Head/Camera3D/8ballin".visible = true
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/InvAnamoly.png")
			Global.Anomlies[6] = true
			Global.hold = true
			Global.active = 3
		if (Global.get.name == "Anamlee8") and Input.is_key_pressed(KEY_E) and Global.Anomlies[7] == false and Global.hold == false and Global.stick == false:
			$Head/Camera3D/skullforglitch.visible = true
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/InvAnamoly.png")
			Global.Anomlies[7] = true
			Global.hold = true
			Global.active = 3
			
		if (Global.get.name == "sx") and Input.is_key_pressed(KEY_E) and Global.stick == false and Global.hold == false:
			$Head/Camera3D/Stick.visible = true
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/InvStick.png")
			Global.stick = true
			Global.whichstick[0] = true
			Global.active = 3
			Global.hold = true
			Global.camp = false
		if (Global.get.name == "s1") and Input.is_key_pressed(KEY_E) and Global.stick == false and Global.hold == false:
			$Head/Camera3D/Stick.visible = true
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/InvStick.png")
			Global.stick = true
			Global.whichstick[1] = true
			Global.active = 3
			Global.hold = true
			Global.camp = false
		if (Global.get.name == "s2") and Input.is_key_pressed(KEY_E) and Global.stick == false and Global.hold == false:
			$Head/Camera3D/Stick.visible = true
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/InvStick.png")
			Global.stick = true
			Global.whichstick[2] = true
			Global.active = 3
			Global.hold = true
			Global.camp = false
		if (Global.get.name == "s3") and Input.is_key_pressed(KEY_E) and Global.stick == false and Global.hold == false:
			$Head/Camera3D/Stick.visible = true
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/InvStick.png")
			Global.stick = true
			Global.whichstick[3] = true
			Global.active = 3
			Global.hold = true
			Global.camp = false
		if (Global.get.name == "s4") and Input.is_key_pressed(KEY_E) and Global.stick == false and Global.hold == false:
			$Head/Camera3D/Stick.visible = true
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/InvStick.png")
			Global.stick = true
			Global.whichstick[4] = true
			Global.active = 3	
			Global.hold = true
			Global.camp = false
		if (Global.get.name == "s5") and Input.is_key_pressed(KEY_E) and Global.stick == false and Global.hold == false:
			$Head/Camera3D/Stick.visible = true
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/InvStick.png")
			Global.stick = true
			Global.whichstick[5] = true
			Global.active = 3
			Global.hold = true
			Global.camp = false
		if (Global.get.name == "s6") and Input.is_key_pressed(KEY_E) and Global.stick == false and Global.hold == false:
			$Head/Camera3D/Stick.visible = true
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/InvStick.png")
			Global.stick = true
			Global.whichstick[6] = true
			Global.active = 3	
			Global.hold = true
			Global.camp = false
		if (Global.get.name == "s7") and Input.is_key_pressed(KEY_E) and Global.stick == false and Global.hold == false:
			$Head/Camera3D/Stick.visible = true
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/InvStick.png")
			Global.stick = true
			Global.whichstick[7] = true
			Global.active = 3	
			Global.hold = true
			Global.camp = false
		if (Global.get.name == "s8") and Input.is_key_pressed(KEY_E) and Global.stick == false and Global.hold == false:
			$Head/Camera3D/Stick.visible = true
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/InvStick.png")
			Global.stick = true
			Global.whichstick[8] = true
			Global.active = 3	
			Global.hold = true
			Global.camp = false
		if (Global.get.name == "s9") and Input.is_key_pressed(KEY_E) and Global.stick == false and Global.hold == false:
			$Head/Camera3D/Stick.visible = true
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/InvStick.png")
			Global.stick = true
			Global.whichstick[9] = true
			Global.active = 3	
			Global.hold = true
			Global.camp = false
		if (Global.get.name == "s10") and Input.is_key_pressed(KEY_E) and Global.stick == false and Global.hold == false:
			$Head/Camera3D/Stick.visible = true
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/InvStick.png")
			Global.stick = true
			Global.whichstick[10] = true
			Global.active = 3	
			Global.hold = true
			Global.camp = false
		if (Global.get.name == "s11") and Input.is_key_pressed(KEY_E) and Global.stick == false and Global.hold == false:
			$Head/Camera3D/Stick.visible = true
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/InvStick.png")
			Global.stick = true
			Global.whichstick[11] = true
			Global.active = 3
			Global.hold = true
			Global.camp = false
		if (Global.get.name == "s12") and Input.is_key_pressed(KEY_E) and Global.stick == false and Global.hold == false:
			$Head/Camera3D/Stick.visible = true
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/InvStick.png")
			Global.stick = true
			Global.whichstick[12] = true
			Global.active = 3	
			Global.hold = true
			Global.camp = false
		if (Global.get.name == "s13") and Input.is_key_pressed(KEY_E) and Global.stick == false and Global.hold == false:
			$Head/Camera3D/Stick.visible = true
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/InvStick.png")
			Global.stick = true
			Global.whichstick[13] = true
			Global.active = 3	
			Global.hold = true
			Global.camp = false
		if (Global.get.name == "s14") and Input.is_key_pressed(KEY_E) and Global.stick == false and Global.hold == false:
			$Head/Camera3D/Stick.visible = true
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/InvStick.png")
			Global.stick = true
			Global.whichstick[14] = true
			Global.active = 3	
			Global.hold = true
			Global.camp = false
		if (Global.get.name == "s15") and Input.is_key_pressed(KEY_E) and Global.stick == false and Global.hold == false:
			$Head/Camera3D/Stick.visible = true
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/InvStick.png")
			Global.stick = true
			Global.whichstick[15] = true
			Global.active = 3	
			Global.hold = true
			Global.camp = false
		if (Global.get.name == "s16") and Input.is_key_pressed(KEY_E) and Global.stick == false and Global.hold == false:
			$Head/Camera3D/Stick.visible = true
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/InvStick.png")
			Global.stick = true
			Global.whichstick[16] = true
			Global.active = 3	
			Global.hold = true
			Global.camp = false
		if (Global.get.name == "s17") and Input.is_key_pressed(KEY_E) and Global.stick == false and Global.hold == false:
			$Head/Camera3D/Stick.visible = true
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/InvStick.png")
			Global.stick = true
			Global.whichstick[17] = true
			Global.active = 3	
			Global.hold = true
			Global.camp = false
		if (Global.get.name == "s18") and Input.is_key_pressed(KEY_E) and Global.stick == false and Global.hold == false:
			$Head/Camera3D/Stick.visible = true
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/InvStick.png")
			Global.stick = true
			Global.whichstick[18] = true
			Global.active = 3	
			Global.hold = true
			Global.camp = false
				
				
		if (Global.get.name == "CAMPFIRE") and Input.is_key_pressed(KEY_E) and Global.Anomlies[0] == true:
			$Head/Camera3D/freddyfastbear.visible = false
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/Inv3E.png")
			Global.Anomlies[0] = false
			Global.acount += 1
			Global.hold = false
			Global.camp = false
		if (Global.get.name == "CAMPFIRE") and Input.is_key_pressed(KEY_E) and Global.Anomlies[1] == true:
			$"Head/Camera3D/toy car".visible = false
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/Inv3E.png")
			Global.Anomlies[1] = false
			Global.acount += 1
			Global.hold = false
			Global.camp = false
		if (Global.get.name == "CAMPFIRE") and Input.is_key_pressed(KEY_E) and Global.Anomlies[2] == true:
			$"Head/Camera3D/gilberts head".visible = false
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/Inv3E.png")
			Global.Anomlies[2] = false
			Global.acount += 1
			Global.hold = false
			Global.camp = false
		if (Global.get.name == "CAMPFIRE") and Input.is_key_pressed(KEY_E) and Global.Anomlies[3] == true:
			$Head/Camera3D/ducky.visible = false
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/Inv3E.png")
			Global.Anomlies[3] = false
			Global.acount += 1
			Global.hold = false
			Global.camp = false
		if (Global.get.name == "CAMPFIRE") and Input.is_key_pressed(KEY_E) and Global.Anomlies[4] == true:
			$Head/Camera3D/cupcake.visible = false
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/Inv3E.png")
			Global.Anomlies[4] = false
			Global.acount += 1
			Global.hold = false
			Global.camp = false
		if (Global.get.name == "CAMPFIRE") and Input.is_key_pressed(KEY_E) and Global.Anomlies[5] == true:
			$Head/Camera3D/sinige.visible = false
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/Inv3E.png")
			Global.Anomlies[5] = false
			Global.acount += 1
			Global.hold = false
			Global.camp = false
		if (Global.get.name == "CAMPFIRE") and Input.is_key_pressed(KEY_E) and Global.Anomlies[6] == true:
			$"Head/Camera3D/8ballin".visible = false
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/Inv3E.png")
			Global.Anomlies[6] = false
			Global.acount += 1
			Global.hold = false
			Global.camp = false
		if (Global.get.name == "CAMPFIRE") and Input.is_key_pressed(KEY_E) and Global.Anomlies[7] == true:
			$Head/Camera3D/skullforglitch.visible = false
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/Inv3E.png")
			Global.Anomlies[7] = false
			Global.acount += 1
			Global.hold = false
			Global.camp = false
		if (Global.get.name == "CAMPFIRE") and Input.is_key_pressed(KEY_E) and Global.stick == true:
			$Head/Camera3D/Stick.visible = false
			$UI/HBoxContainer/TextureRect3.texture = load("res://Game/UI/Images/Inv3E.png")
			Global.stick = false
			Global.scount += 1
			Global.hold = false
			Global.camp = false
			
		
		if Global.acount == 0:
			$Counter.texture = load("res://Game/UI/Images/Exterminated0.png")
		if Global.acount == 1:
			$Counter.texture = load("res://Game/UI/Images/Exterminated1.png")
		if Global.acount == 2:
			$Counter.texture = load("res://Game/UI/Images/Exterminated2.png")
		if Global.acount == 3:
			$Counter.texture = load("res://Game/UI/Images/Exterminated3.png")
		if Global.acount == 4:
			$Counter.texture = load("res://Game/UI/Images/Exterminated4.png")
		if Global.acount == 5:
			$Counter.texture = load("res://Game/UI/Images/Exterminated5.png")
		if Global.acount == 6:
			$Counter.texture = load("res://Game/UI/Images/Exterminated6.png")
		if Global.acount == 7:
			$Counter.texture = load("res://Game/UI/Images/Exterminated7.png")
		if Global.acount == 8:
			$Counter.texture = load("res://Game/UI/Images/Exterminated8.png")
		
		
		
	if Input.is_key_pressed(KEY_1) and Global.Anomlies[0] == true:
		$Head/Camera3D/freddyfastbear.visible = false
	if Input.is_key_pressed(KEY_2) and Global.Anomlies[0] == true:
		$Head/Camera3D/freddyfastbear.visible = false
	if Input.is_key_pressed(KEY_3) and Global.Anomlies[0] == true:
		$Head/Camera3D/freddyfastbear.visible = true
			
	if Input.is_key_pressed(KEY_1) and Global.Anomlies[1] == true:
		$"Head/Camera3D/toy car".visible = false
	if Input.is_key_pressed(KEY_2) and Global.Anomlies[1] == true:
		$"Head/Camera3D/toy car".visible = false
	if Input.is_key_pressed(KEY_3) and Global.Anomlies[1] == true:
		$"Head/Camera3D/toy car".visible = true
	
	if Input.is_key_pressed(KEY_1) and Global.Anomlies[2] == true:
		$"Head/Camera3D/gilberts head".visible = false
	if Input.is_key_pressed(KEY_2) and Global.Anomlies[2] == true:
		$"Head/Camera3D/gilberts head".visible = false
	if Input.is_key_pressed(KEY_3) and Global.Anomlies[2] == true:
		$"Head/Camera3D/gilberts head".visible = true
			
	if Input.is_key_pressed(KEY_1) and Global.Anomlies[3] == true:
		$Head/Camera3D/ducky.visible = false
	if Input.is_key_pressed(KEY_2) and Global.Anomlies[3] == true:
		$Head/Camera3D/ducky.visible = false
	if Input.is_key_pressed(KEY_3) and Global.Anomlies[3] == true:
		$Head/Camera3D/ducky.visible = true
			
	if Input.is_key_pressed(KEY_1) and Global.Anomlies[4] == true:
		$Head/Camera3D/cupcake.visible = false
	if Input.is_key_pressed(KEY_2) and Global.Anomlies[4] == true:
		$Head/Camera3D/cupcake.visible = false
	if Input.is_key_pressed(KEY_3) and Global.Anomlies[4] == true:
		$Head/Camera3D/cupcake.visible = true
	
	if Input.is_key_pressed(KEY_1) and Global.Anomlies[5] == true:
		$Head/Camera3D/sinige.visible = false
	if Input.is_key_pressed(KEY_2) and Global.Anomlies[5] == true:
		$Head/Camera3D/sinige.visible = false
	if Input.is_key_pressed(KEY_3) and Global.Anomlies[5] == true:
		$Head/Camera3D/sinige.visible = true

	if Input.is_key_pressed(KEY_1) and Global.Anomlies[6] == true:
		$"Head/Camera3D/8ballin".visible = false
	if Input.is_key_pressed(KEY_2) and Global.Anomlies[6] == true:
		$"Head/Camera3D/8ballin".visible = false
	if Input.is_key_pressed(KEY_3) and Global.Anomlies[6] == true:
		$"Head/Camera3D/8ballin".visible = true

	if Input.is_key_pressed(KEY_1) and Global.Anomlies[7] == true:
		$Head/Camera3D/skullforglitch.visible = false
	if Input.is_key_pressed(KEY_2) and Global.Anomlies[7] == true:
		$Head/Camera3D/skullforglitch.visible = false
	if Input.is_key_pressed(KEY_3) and Global.Anomlies[7] == true:
		$Head/Camera3D/skullforglitch.visible = true

	if Input.is_key_pressed(KEY_1) and Global.stick == true:
		$Head/Camera3D/Stick.visible = false
	if Input.is_key_pressed(KEY_2) and Global.stick == true:
		$Head/Camera3D/Stick.visible = false
	if Input.is_key_pressed(KEY_3) and Global.stick == true:
		$Head/Camera3D/Stick.visible = true
		
		
	if 	Global.active != 3:
		$Head/Camera3D/Stick.visible = false
		$Head/Camera3D/sinige.visible = false
		$Head/Camera3D/cupcake.visible = false
		$Head/Camera3D/ducky.visible = false
		$"Head/Camera3D/gilberts head".visible = false
		$"Head/Camera3D/toy car".visible = false
		$Head/Camera3D/freddyfastbear.visible = false
		$"Head/Camera3D/8ballin".visible = false
		$Head/Camera3D/skullforglitch.visible = false
