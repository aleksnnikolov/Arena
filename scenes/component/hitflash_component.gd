extends Node

@export var health_component: Node
@export var sprite: Sprite2D
@export var hitflash_material: ShaderMaterial

var hitflash_tween: Tween

func _ready():
	health_component.health_decreased.connect(on_health_decreased)
	sprite.material = hitflash_material


func on_health_decreased():
	if hitflash_tween != null && hitflash_tween.is_valid():
		hitflash_tween.kill()
	
	(sprite.material as ShaderMaterial).set_shader_parameter("lerp_percent", 1.0)
	hitflash_tween = create_tween()
	hitflash_tween.tween_property(sprite.material, "shader_parameter/lerp_percent", 0.0, 0.2)\
				  .set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	
