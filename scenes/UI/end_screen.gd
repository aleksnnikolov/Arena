extends CanvasLayer

@onready var panel_container = %PanelContainer

func _ready():
	panel_container.pivot_offset = panel_container.size / 2
	
	var tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0)
	tween.tween_property(panel_container, "scale", Vector2.ONE, 0.3)\
		 .set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	
	
	get_tree().paused = true
	%RestartButton.pressed.connect(on_restart_pressed)
	%QuitButton.pressed.connect(on_quit_pressed)


func set_victory():
	%TitleLabel.text = "VICTORY"
	%DescLabel.text = "You Won!"
	play_jingle(false)
	

func set_defeat():
	%TitleLabel.text = "DEFEAT"
	%DescLabel.text = "You Died!"
	play_jingle(true)


func play_jingle(defeat: bool):
	if defeat:
		$DefeatStreamPlayer.play()
	else:
		$VictoryStreamPlayer.play()


func on_restart_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func on_quit_pressed():
	get_tree().quit()
