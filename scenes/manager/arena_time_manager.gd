extends Node

const DIFFICULTY_INTERVAL = 5

signal time_elapsed
signal difficulty_increased(difficulty: int)

@onready var timer: Timer = $Timer

var difficulty: int = 0

func _ready():
	timer.timeout.connect(on_timer_timeout)


func _process(delta):
	var next_time_target = timer.wait_time - ((difficulty + 1) * DIFFICULTY_INTERVAL)
	if timer.time_left <= next_time_target:
		difficulty += 1
		difficulty_increased.emit(difficulty)


func get_time_elapsed():
	return timer.wait_time - timer.time_left


func on_timer_timeout():
	time_elapsed.emit()
