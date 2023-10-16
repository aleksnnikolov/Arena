extends Node

signal experience_updated(current_xp: float, target_xp: float)
signal leveled_up(new_level: int)

const TARGET_XP_GROWTH = 5

var current_level: int = 1
var current_xp: float = 0
var target_xp: float = 1


func _ready():
	GameEvents.experience_drop_collected.connect(xp_drop_collected)


func xp_drop_collected(amount: float):
	increment_xp(amount)
	experience_updated.emit(current_xp, target_xp)
	if current_xp == target_xp:
		current_level += 1
		target_xp += TARGET_XP_GROWTH
		current_xp = 0
		experience_updated.emit(current_xp, target_xp)
		leveled_up.emit(current_level)


func increment_xp(amount: float):
	current_xp = min(current_xp + amount, target_xp)
