extends Area2D

func _on_Dock_body_entered(body):
	if body.has_method("open_menu"):
		body.open_menu()

func _on_Dock_body_exited(body):
	if body.has_method("close_menu"):
		body.close_menu()
