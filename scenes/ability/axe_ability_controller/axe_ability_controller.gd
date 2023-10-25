extends Node

@export var axe_ability: PackedScene
var base_damage: float = 10
var additional_damage_percent = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return	
	
	var axe_instance = axe_ability.instantiate() as Node2D
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
	foreground_layer.add_child(axe_instance)
	
	axe_instance.hitbox_component.damage = base_damage * additional_damage_percent
	axe_instance.global_position = player.global_position


func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id == "axe_damage":
		additional_damage_percent =  1 + (current_upgrades["axe_damage"]["quantity"] * 0.1)
