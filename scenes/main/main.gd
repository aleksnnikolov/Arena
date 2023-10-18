extends Node

@export var end_screen_scene: PackedScene
@onready var arena_time_manager: Node = $ArenaTimeManager

func _ready():
	%Player.health_component.died.connect(on_player_died)
	arena_time_manager.time_elapsed.connect(on_game_won)


func on_game_won():
	var end_screen_instance = end_screen_scene.instantiate()
	add_child(end_screen_instance)
	end_screen_instance.set_victory()


func on_player_died():
	var end_screen_instance = end_screen_scene.instantiate()
	add_child(end_screen_instance)
	end_screen_instance.set_defeat()
