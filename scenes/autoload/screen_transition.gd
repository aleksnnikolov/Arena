extends CanvasLayer

signal transitioned_halfway

var skip_emit: bool = false


func transition_to_scene(scene_path: String):
	transition()
	await transitioned_halfway
	get_tree().change_scene_to_file(scene_path)


func transition():
	$AnimationPlayer.play("transition")
	await transitioned_halfway
	skip_emit = true
	$AnimationPlayer.play_backwards("transition")


func emit_transitioned_halfway():
	if skip_emit:
		skip_emit = false
		return
	
	transitioned_halfway.emit()
