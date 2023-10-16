extends CanvasLayer

@export var experience_manager: Node
@onready var progress_bar = $MarginContainer/ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	experience_manager.experience_updated.connect(on_xp_updated)
	progress_bar.value = 0


func on_xp_updated(current_xp: float, target_xp: float):
	var percent = current_xp / target_xp
	progress_bar.value = percent
