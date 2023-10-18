extends Node

const SPAWN_RADIUS = 350


@export var arena_time_manager: Node
@export var rat_enemy_scene: PackedScene
@export var wizard_enemy_scene: PackedScene
@onready var timer: Timer = $Timer
var player: Node2D
var base_spawn_time: float 
var enemy_table = WeightedTable.new()

func _ready():
	enemy_table.add_item(rat_enemy_scene, 10)
	timer.timeout.connect(on_timer_timeout)
	arena_time_manager.difficulty_increased.connect(on_difficulty_increased)
	player = get_tree().get_first_node_in_group("player")
	base_spawn_time = timer.wait_time


func get_spawn_position() -> Vector2:
	if player == null:
		return Vector2.ZERO
	
	var spawn_position = Vector2.ZERO
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	for i in 4:
		spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)
		
		var raycast_params = PhysicsRayQueryParameters2D.create(player.global_position, spawn_position, 1)
		var result = get_tree().root.world_2d.direct_space_state.intersect_ray(raycast_params)
		
		if result.is_empty():
			return spawn_position
		else:
			random_direction = random_direction.rotated(deg_to_rad(90))
	
	return spawn_position


func on_timer_timeout():
	timer.start()
	
	var enemy_scene = enemy_table.pick_item()
	var enemy_instance = enemy_scene.instantiate() as Node2D
	
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(enemy_instance)
	enemy_instance.global_position = get_spawn_position()


func on_difficulty_increased(difficulty: int):
	var time_off = (0.1 / 12) * difficulty
	time_off = min(time_off, 0.3)
	timer.wait_time = base_spawn_time - time_off
	print(timer.wait_time)
	
	if difficulty == 6:
		enemy_table.add_item(wizard_enemy_scene, 20)
