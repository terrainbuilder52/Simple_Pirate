extends Control

var scene = ""
onready var tween = get_node("Tween")

func _ready():
	Global.time_now = 0

func _on_Quit_pressed():
	get_tree().quit()


func _on_Start_pressed():
	scene = "res://World.tscn"
	tween.interpolate_property($VBoxContainer, "margin_left", $VBoxContainer.margin_left, -300, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()



func _on_Tween_tween_all_completed():
	get_tree().change_scene(scene)


func _on_Tutorial_pressed():
	scene = "res://Tutorial.tscn"
	tween.interpolate_property($VBoxContainer, "margin_left", $VBoxContainer.margin_left, -300, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
