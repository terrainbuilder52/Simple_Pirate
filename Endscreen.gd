extends Control

onready var tween = get_node("Tween")

func _ready():
	tween.interpolate_property($Credits, "margin_top", $Credits.margin_top, -75, 5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()


func _on_Quit_pressed():
	get_tree().quit()


func _on_Continue_pressed():
	get_tree().change_scene("res://World.tscn")


func _on_Menu_pressed():
	get_tree().change_scene("res://Main.tscn")
