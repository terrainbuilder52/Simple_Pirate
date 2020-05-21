extends Node2D

func _ready():
	randomize()
	Global.scene = "res://World.tscn"
	Global.time_now = 0


func _on_Player_death():
	get_tree().change_scene("res://Endscreen.tscn")


func _on_HomeIsland_death():
	get_tree().change_scene("res://Endscreen.tscn")
