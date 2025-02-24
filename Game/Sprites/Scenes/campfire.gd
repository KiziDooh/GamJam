extends Node3D

var blank = 0
var timerstart = false
# Called when the node enters the scene tree for the first time.
func _ready():
	#$GPUParticles3D.amount = 50
	#$GPUParticles3D/OmniLight3D.light_energy = 3
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if Global.isnight == true:
		if Global.die == true:
			Global.gameover = false
			Global.Firetimer = 30
			Global.die = false
		if timerstart == false:
			$Timer.start()
			timerstart = true
	#print(timer)
	if Global.Firetimer > 25:
		$GPUParticles3D.amount = 70
		$GPUParticles3D/OmniLight3D.light_energy = 30
		
	if Global.Firetimer == 25:
		$GPUParticles3D.amount = 60
		$GPUParticles3D/OmniLight3D.light_energy = 25
		
	if Global.Firetimer == 20:
		$GPUParticles3D.amount = 50
		$GPUParticles3D/OmniLight3D.light_energy = 20
		
	if Global.Firetimer == 15:
		$GPUParticles3D.amount = 45
		$GPUParticles3D/OmniLight3D.light_energy = 15

	if Global.Firetimer == 10:
		$GPUParticles3D.amount = 40
		$GPUParticles3D/OmniLight3D.light_energy = 10

	if Global.Firetimer == 7:
		$GPUParticles3D.amount = 35
		$GPUParticles3D/OmniLight3D.light_energy = 6

	if Global.Firetimer == 6:
		$GPUParticles3D.amount = 30
		$GPUParticles3D/OmniLight3D.light_energy = 4

	if Global.Firetimer == 5:
		$GPUParticles3D.amount = 25
		$GPUParticles3D/OmniLight3D.light_energy = 2.5
		
	if Global.Firetimer == 4:
		$GPUParticles3D.amount = 20
		$GPUParticles3D/OmniLight3D.light_energy = 2
	if Global.Firetimer == 3:
		$GPUParticles3D.amount = 15
		$GPUParticles3D/OmniLight3D.light_energy = 1.5
	if Global.Firetimer == 2:
		$GPUParticles3D.amount = 10
		$GPUParticles3D/OmniLight3D.light_energy = 1
	if Global.Firetimer == 1:
		$GPUParticles3D.amount = 5
		$GPUParticles3D/OmniLight3D.light_energy = 0.5

	if Global.Firetimer == 0:
		$GPUParticles3D.emitting = false
		$GPUParticles3D/OmniLight3D.light_energy = 0
		
	if Global.gameover == true and Global.die == false:
		$GPUParticles3D.emitting = false
		$GPUParticles3D/OmniLight3D.light_energy = 0
		
			
	if Global.Firetimer == -1:
		Global.gameover = true
		Global.die = true
		get_tree().change_scene_to_file("res://Game/Places/GameOverScreen.tscn")
		Global.yup = false
		Global.isnight = false
		
		
	if blank < Global.scount:
		blank += 1
		Global.Firetimer += 1

func _on_timer_timeout():
	Global.Firetimer = Global.Firetimer - 1
	timerstart = false
