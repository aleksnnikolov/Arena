extends Node

@export var end_screen_scene: PackedScene
@onready var arena_time_manager: Node = $ArenaTimeManager

var pause_menu_scene = preload("res://scenes/UI/pause_menu.tscn")

func _ready():
	%Player.health_component.died.connect(on_player_died)
	arena_time_manager.time_elapsed.connect(on_game_won)


func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		add_child(pause_menu_scene.instantiate())
		get_tree().root.set_input_as_handled()


func on_game_won():
	var end_screen_instance = end_screen_scene.instantiate()
	add_child(end_screen_instance)
	end_screen_instance.set_victory()
	MetaProgression.save()


func on_player_died():
	var end_screen_instance = end_screen_scene.instantiate()
	add_child(end_screen_instance)
	end_screen_instance.set_defeat()
	MetaProgression.save()
