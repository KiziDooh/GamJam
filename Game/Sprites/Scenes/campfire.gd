extends Node3D

var timer = 6
var timerstart = false
# Called when the node enters the scene tree for the first time.
func _ready():
	#$GPUParticles3D.amount = 50
	#$GPUParticles3D/OmniLight3D.light_energy = 3
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if Global.isnight == true:
		if timerstart == false:
			$Timer.start()
			timerstart = true
	#print(timer)
	if timer == 7:
		$GPUParticles3D.amount = 60
		$GPUParticles3D/OmniLight3D.light_energy = 3.5
		
	if timer == 6:
		$GPUParticles3D.amount = 50
		$GPUParticles3D/OmniLight3D.light_energy = 3
		
	if timer == 5:
		$GPUParticles3D.amount = 40
		$GPUParticles3D/OmniLight3D.light_energy = 2.5

	if timer == 4:
		$GPUParticles3D.amount = 30
		$GPUParticles3D/OmniLight3D.light_energy = 2

	if timer == 3:
		$GPUParticles3D.amount = 20
		$GPUParticles3D/OmniLight3D.light_energy = 1.5

	if timer == 2:
		$GPUParticles3D.amount = 10
		$GPUParticles3D/OmniLight3D.light_energy = 1

	if timer == 1:
		$GPUParticles3D.amount = 5
		$GPUParticles3D/OmniLight3D.light_energy = 0.5

	if timer == 0:
		$GPUParticles3D.emitting = false
		$GPUParticles3D/OmniLight3D.light_energy = 0
		
	if Global.gameover == true:
		$GPUParticles3D.emitting = false
		$GPUParticles3D/OmniLight3D.light_energy = 0
		
			
	if timer == -1:
		Global.gameover = true
		print(Global.gameover)
		get_tree().change_scene_to_file("res://Game/Places/GameOverScreen.tscn")
		Global.yup = false
		Global.isnight = false
	

func _on_timer_timeout():
	timer = timer - 1
	timerstart = false
