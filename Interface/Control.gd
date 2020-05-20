extends Control


func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		var new_paused_state = not get_tree().paused
		get_tree().paused = new_paused_state
		$Paused.visible = new_paused_state


func _on_Quit_pressed():
	get_tree().quit()


func _on_Continue_pressed():
	get_tree().paused = false
	$Paused.visible = false
