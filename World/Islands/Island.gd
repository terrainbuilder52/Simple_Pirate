extends StaticBody2D

var max_health = 100
var health = max_health

signal death
signal hit

func _process(delta):
	health = clamp(health, 0, max_health)
	$IslandCounter/Label.text = str(health)
	
	#DEATH
	if health <= 0:
		on_death()
	
func hit():
	health -= 1
	emit_signal("hit")

func on_death():
	emit_signal("death")
