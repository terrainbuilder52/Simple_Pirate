extends Node2D

func _ready():
	randomize()


func _on_Player_death():
	get_tree().change_scene("res://Endscreen.tscn")


func _on_HomeIsland_death():
	get_tree().change_scene("res://Endscreen.tscn")
