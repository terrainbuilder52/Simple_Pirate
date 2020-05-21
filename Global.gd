extends Node

var time_now = 0
var time_start = 0

var frames = 0

var scene = ""

var str_elapsed = ""

func _process(delta):
	if scene == "res://World.tscn":
		if frames >= 60:
			frames = 0
			time_now += 1
		else:
			frames += 1

	var elapsed = time_now - time_start
	var minutes = elapsed / 60
	var seconds = elapsed % 60
	str_elapsed = "%02d : %02d" % [floor(minutes), seconds]
func get_time():
	return str_elapsed
