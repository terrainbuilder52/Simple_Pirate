extends StaticBody2D

onready var PIRATE_SCENE = preload("res://Pirate/Pirate.tscn")

func _ready():
	randomize()
	$Timer.start(10)

func _on_Timer_timeout():
	var pirate = PIRATE_SCENE.instance()
	pirate.position = $Position2D.get_global_position()
	get_parent().add_child(pirate)
	$Timer.set_wait_time(rand_range(20, 60))
