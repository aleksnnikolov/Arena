extends Node2D

var experience_amount: float = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.area_entered.connect(on_area_entered)


func on_area_entered(other_area: Area2D):
	GameEvents.emit_experience_drop_collected(experience_amount)
	queue_free()
