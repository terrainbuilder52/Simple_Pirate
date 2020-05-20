extends KinematicBody2D

onready var GOLDCOIN_SCENE = preload("res://World/Gold/GoldCoin.tscn")
onready var ISLAND_SCENE = preload("res://World/Islands/Island.tscn")
onready var PIRATEBALL_SCENE = preload("res://Pirate/CannonballE.tscn")

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

export var health = 3

var run_speed = 30
var velocity = Vector2.ZERO
var signed_vector = Vector2.ZERO
var player = null
var island = null
var pirate_arrived = false
var cannonball_life_time = .8

func _ready():
	add_to_group("enemies")

# warning-ignore:unused_argument
func _physics_process(delta):
	velocity = Vector2.ZERO
	signed_vector = Vector2.ZERO
	if player:
		velocity = -position.direction_to(player.position) * run_speed
		signed_vector.x = sign(velocity.x)
		signed_vector.y = sign(velocity.y)

	elif pirate_arrived:
		velocity = Vector2.ZERO
		
	else:
		velocity = position.direction_to(Vector2(640, 360)) * run_speed # Center of the map
		
		signed_vector.x = sign(velocity.x)
		signed_vector.y = sign(velocity.y)
	
	
	
		#SET ANIMATION
	if signed_vector.x != 0:
		animationTree.set("parameters/Idle/blend_position", signed_vector.x)
		animationTree.set("parameters/Move/blend_position", signed_vector.x)
		animationState.travel("Move")
		signed_vector = signed_vector.normalized()
	
	if signed_vector == Vector2.ZERO:
		animationState.travel("Idle")
		
	
	velocity = move_and_slide(velocity)

# warning-ignore:unused_argument
func _process(delta):
	if health <= 0:
		on_death()

func _on_DetectionArea_body_entered(body):
	if body.has_method("im_player"):
		player = body

func _on_DetectionArea_body_exited(body):
	if body.has_method("im_player"):
		player = null

func hit_enemy(dmg):
	health -= dmg
	
func fire_object_at(object):
	var cannonball = PIRATEBALL_SCENE.instance()
	cannonball.position = get_global_position()
	cannonball.life(cannonball_life_time)
	get_parent().add_child(cannonball)
	cannonball.get_world_objects(object)
	cannonball.parent = self
	cannonball.player = player
	$Timer.set_wait_time(1)
	$Timer.start()

func on_death():
	#drop gold
	for i in int(rand_range(1, 4)):
		var goldcoin = GOLDCOIN_SCENE.instance()
		goldcoin.position = (get_global_position() + Vector2(rand_range(0, 5), rand_range(0, 5)))
		get_parent().add_child(goldcoin)
	queue_free()
	

func _on_Timer_timeout():
	if player:
		fire_object_at(player)
	elif island:
		fire_object_at(island)

func _on_DetectionArea_area_entered(area):
	if area.has_method("island"):
		pirate_arrived = true
		cannonball_life_time = 2
		island = area.island()


func _on_DetectionArea_area_exited(area):
	if area.has_method("island"):
		pirate_arrived = false
		cannonball_life_time = 0.8
		island = null
