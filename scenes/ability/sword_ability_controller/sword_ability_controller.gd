extends Node

@export var sword_ability: PackedScene

var base_wait_time: float

var damage: float = 5
const MAX_RANGE = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)
	$Timer.timeout.connect(on_timer_timeout)
	base_wait_time = $Timer.wait_time


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
		
	var enemies = get_tree().get_nodes_in_group("enemy")
	enemies = enemies.filter(func(enemy: Node2D):
		return enemy.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE, 2)
	)
	
	if enemies.size() == 0:
		return
	
	enemies.sort_custom(func(a: Node2D, b: Node2D):
		var a_distance = a.global_position.distance_squared_to(player.global_position)
		var b_distance = b.global_position.distance_squared_to(player.global_position)
		
		return a_distance < b_distance
	)
	
	var closest_enemy = enemies[0]
	
	var sword_instance = sword_ability.instantiate() as SwordAbility
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
	foreground_layer.add_child(sword_instance)
	
	sword_instance.hitbox_component.damage = damage
	sword_instance.global_position = closest_enemy.global_position
	sword_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4
	
	var enemy_direction = closest_enemy.global_position - sword_instance.global_position
	sword_instance.rotation = enemy_direction.angle()


func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id != "sword_rate":
		return
	
	var reduction_stack = current_upgrades["sword_rate"]["quantity"]
	var new_wait_time = base_wait_time
	for n in range(reduction_stack, 0, -1):
		new_wait_time = new_wait_time * (1 - 0.1)
		
	$Timer.wait_time = new_wait_time
	$Timer.start()


