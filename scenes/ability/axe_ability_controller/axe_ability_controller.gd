extends Node

@export var axe_ability: PackedScene
var damage = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return	
	
	var axe_instance = axe_ability.instantiate() as Node2D
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
	foreground_layer.add_child(axe_instance)
	
	axe_instance.hitbox_component.damage = damage
	axe_instance.global_position = player.global_position
