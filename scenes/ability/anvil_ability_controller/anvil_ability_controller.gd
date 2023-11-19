extends Node

const BASE_DAMAGE = 15
const BASE_RANGE = 100

@export var anvil_ability_scene: PackedScene

var anvil_amount = 0
var player: Node2D

func _ready():
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)
	$Timer.timeout.connect(on_timer_timeout)
	player = get_tree().get_first_node_in_group("player")


func on_timer_timeout():
	for i in anvil_amount + 1:
		var spawn_position = get_spawn_position()
		
		var anvil_instance = anvil_ability_scene.instantiate()
		var entities_layer = get_tree().get_first_node_in_group("entities_layer")
		entities_layer.add_child(anvil_instance)
		anvil_instance.global_position = spawn_position
		anvil_instance.hitbox_component.damage = BASE_DAMAGE
	

func get_spawn_position() -> Vector2:
	if player == null:
		return Vector2.ZERO
	
	var spawn_position = Vector2.ZERO
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	for i in 4:
		spawn_position = player.global_position + (random_direction * BASE_RANGE)
		var additional_check_offset = random_direction * 20
		
		var raycast_params = PhysicsRayQueryParameters2D.create(player.global_position, spawn_position + additional_check_offset, 1)
		var result = get_tree().root.world_2d.direct_space_state.intersect_ray(raycast_params)
		
		if result.is_empty():
			return spawn_position
		else:
			random_direction = random_direction.rotated(deg_to_rad(90))
	
	return spawn_position


func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id == "anvil_amount":
		anvil_amount = current_upgrades["anvil_amount"]["quantity"]
