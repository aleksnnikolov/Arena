extends CanvasLayer

signal transitioned_halfway

func transition_to_scene(scene_path: String):
	transition()
	await transitioned_halfway
	get_tree().change_scene_to_file(scene_path)


func transition():
	$ColorRect.visible = true
	
	$AnimationPlayer.play("transition")
	await $AnimationPlayer.animation_finished
	
	transitioned_halfway.emit()
	
	$AnimationPlayer.play_backwards("transition")
	await $AnimationPlayer.animation_finished
	
	$ColorRect.visible = false
