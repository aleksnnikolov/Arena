extends Node

@export_range(0, 1) var drop_percent: float = 0.5
@export var health_component: HealthComponent
@export var xp_drop_scene: PackedScene

func _ready():
	health_component.died.connect(on_died)


func on_died():
	if randf() > drop_percent:
		return
	
	if xp_drop_scene == null:
		return
	
	if not owner is Node2D:
		return
	
	var spawn_position = (owner as Node2D).global_position
	var drop_instance = xp_drop_scene.instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.call_deferred("add_child", drop_instance)
	drop_instance.global_position = spawn_position
