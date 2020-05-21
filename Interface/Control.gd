extends Control

var hint_num = 0 
func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		var new_paused_state = not get_tree().paused
		get_tree().paused = new_paused_state
		$Paused.visible = new_paused_state


func _process(delta):
	if hint_num == 0 and (Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right")):
		$Hints.text = "Hint: Click Left-Mouse button to shoot."
		hint_num += 1
	elif hint_num == 1 and (Input.is_action_just_pressed("ui_mouse_left")):
		$Hints.text = "Hint: Hold Spacebar to speed up and ram ship."
		hint_num += 1
	elif hint_num == 2 and (Input.is_action_just_pressed("ui_select")):
		$Hints.text = "Hint: Stop at the Skull Island dock to resupply."
		$Timer.set_wait_time(20)
		$Timer.start()
	elif hint_num == 3:
		$Hints.text = "Defend your island from the Empire!"
		$Timer.set_wait_time(20)
	elif hint_num == 4:
		$Hints.text = ""

func _on_Quit_pressed():
	get_tree().quit()


func _on_Continue_pressed():
	get_tree().paused = false
	$Paused.visible = false


func _on_Timer_timeout():
	hint_num += 1
