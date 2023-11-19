extends Node
class_name HealthComponent

signal died
signal health_changed
signal health_decreased
signal health_increased

@export var max_health: float = 10
var current_health: float

func _ready():
	current_health = max_health

func damage(amount: float):
	current_health = max(current_health - amount, 0)
	health_changed.emit()
	if amount > 0:
		health_decreased.emit()
	check_death()


func heal(amount: float):
	current_health = min(current_health + amount, max_health)
	health_changed.emit()
	if amount > 0:
		health_increased.emit()


func get_health_percent():
	if current_health <= 0:
		return 0
	return min(current_health / max_health, 1)


func check_death():
	if current_health == 0:
		died.emit()
		owner.queue_free()
