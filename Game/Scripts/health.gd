extends Node

class_name Health

signal max_health_changed(diff: int)
signal health_changed(diff: int)
signal health_depleated


@export var max_health: int = 4 : set = set_max_health, get = get_max_health
@export var invincibility: bool = false : set = set_invincibility, get = get_invincibility

var invincibility_timer: Timer = null

@onready var health: int = max_health : set = set_health, get = get_health

func set_max_health(value: int):
	var clamped_value = 1 if value <0 else value
	
	if not clamped_value == max_health:
		var difference = clamped_value - max_health
		max_health = value
		max_health_changed.emit(difference)
		
		if health > max_health:
			health = max_health
	
func get_max_health() -> int:
	return max_health
	
func set_invincibility(value: bool):
	invincibility = value
	
func get_invincibility() -> bool:
	return invincibility
	
func set_temp_invincibility(time: float):
	if invincibility_timer == null:
		invincibility_timer = Timer.new()
		invincibility_timer.one_shot = true
		add_child(invincibility_timer)
		
	if invincibility_timer.timeout.is_connected(set_invincibility):
		invincibility_timer.timeout.disconnect(set_invincibility)
		
	invincibility_timer.set_wait_time(time)
	invincibility_timer.timeout.connect(set_invincibility.bind(false))
	invincibility = true
	invincibility_timer.start()
	
func set_health(value: int):
	if value < health and invincibility:
		return
	
	var clamped_value = clampi(value, 0, max_health)
	
	if clamped_value != health:
		var difference = clamped_value - health
		health = clamped_value
		health_changed.emit(difference)
		
		if health == 0:
			health_depleated.emit()
	
func get_health():
	return health
