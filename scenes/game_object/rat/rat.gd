extends CharacterBody2D

var player: Node2D
var MAX_SPEED: int = 50

@onready var health_component: HealthComponent = $HealthComponent
@onready var visuals: Node2D = $Visuals

func _ready():
	player = get_tree().get_first_node_in_group("player") as Node2D


func _process(_delta):
	var direction = get_direction_to_player()
	velocity = direction * MAX_SPEED
	move_and_slide()
	
	var move_sign = sign(velocity.x)
	if move_sign != 0:
		visuals.scale = Vector2(-move_sign, 1)


func get_direction_to_player():
	if player != null:
		return (player.global_position - global_position).normalized()
	else:
		return Vector2.ZERO
