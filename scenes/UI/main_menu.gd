extends CanvasLayer

var options_scene = preload("res://scenes/UI/options_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	%PlayButton.pressed.connect(on_press_play)
	%UpgradesButton.pressed.connect(on_press_upgrades)
	%OptionsButton.pressed.connect(on_press_options)
	%QuitButton.pressed.connect(on_press_quit)


func on_press_play():
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func on_press_upgrades():
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	get_tree().change_scene_to_file("res://scenes/UI/meta_menu.tscn")


func on_press_options():
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	var options_instance = options_scene.instantiate()
	add_child(options_instance)
	options_instance.back_pressed.connect(on_options_closed.bind(options_instance))


func on_options_closed(options_instance: Node):
	options_instance.queue_free()


func on_press_quit():
	get_tree().quit()
