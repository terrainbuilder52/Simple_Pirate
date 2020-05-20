extends Area2D

onready var PIRATE_SCENE = preload("res://Pirate/Pirate.tscn")
export var speed = 3
var movement = Vector2()
onready var mouse_pos = null
# Called when the node enters the scene tree for the first time.
func _ready():
	mouse_pos = get_local_mouse_position()

func _physics_process(delta):
	# MOVE CANNONBALL TOWARD MOUSE
	movement = movement.move_toward(mouse_pos + Vector2(rand_range(-10, 10), rand_range(-10, 10)), delta)
	movement = movement.normalized() * speed
	position = position + movement
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

#For if cannon ball hits anything (on it's layer)
func _on_Cannonball_body_entered(body):
	if body.has_method("hit_enemy"): #Check for hit method in pirate instance
		body.hit_enemy(1) #Do it
	queue_free()

func life(number):
	$Timer.set_wait_time(number)
	$Timer.start()

func _on_Timer_timeout():
	queue_free()
