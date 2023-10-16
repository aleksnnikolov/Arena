extends Camera2D

var player: Node2D
var target_position = Vector2.ZERO


func _ready():
	make_current()
	var player_nodes = get_tree().get_nodes_in_group("player")
	if player_nodes.size() > 0:
		player = player_nodes[0] as Node2D



func _process(delta):
	acquire_target()
	global_position = global_position.lerp(target_position, 1.0 - exp(-delta * 20))


func acquire_target():
	if player == null:
		return
	
	target_position = player.global_position
