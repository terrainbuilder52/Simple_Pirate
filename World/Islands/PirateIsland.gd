extends StaticBody2D

onready var PIRATE_SCENE = preload("res://Pirate/Pirate.tscn")

var min_spawn = 20
var max_spawn = 60

func _ready():
	randomize()
	$Timer.start(rand_range(min_spawn, max_spawn))

func _on_Timer_timeout():
	var pirate = PIRATE_SCENE.instance()
	pirate.position = $Position2D.get_global_position()
	get_parent().add_child(pirate)
	$Timer.set_wait_time(rand_range(min_spawn, max_spawn))
	max_spawn -= 1
	max_spawn = clamp(max_spawn, min_spawn, max_spawn)
	
