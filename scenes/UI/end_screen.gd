extends CanvasLayer


func _ready():
	get_tree().paused = true
	%RestartButton.pressed.connect(on_restart_pressed)
	%QuitButton.pressed.connect(on_quit_pressed)


func set_victory():
	%TitleLabel.text = "VICTORY"
	%DescLabel.text = "You Won!"


func set_defeat():
	%TitleLabel.text = "DEFEAT"
	%DescLabel.text = "You Died!"


func on_restart_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func on_quit_pressed():
	get_tree().quit()