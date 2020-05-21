extends KinematicBody2D

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

const FRICTION = 100
const ACCELERATION = 100
var MAX_SPEED = 40
var velocity = Vector2.ZERO

var CANNONBALL_SCENE = preload("res://Player/Cannonball.tscn")
export var cannonball = 20
export var cannonball_cost = 5
export var cooldown = 1

export var gold = 0
export var max_health = 10
var health = max_health
export var repair_cost = 5
var island_max_health = 100
var island_health = island_max_health

signal death

var can_fire = true
		
func _process(delta):
	#UPDATE INTERFACE
	if gold >= 100:
		$Camera2D/CanvasLayer/Control/GoldCounter/Label.text = "99+"
	else:
		$Camera2D/CanvasLayer/Control/GoldCounter/Label.text = str(gold)
		
	if cannonball >= 100:
		$Camera2D/CanvasLayer/Control/CannonCounter/Label.text = "99+"
	else:
		$Camera2D/CanvasLayer/Control/CannonCounter/Label.text = str(cannonball)
	
	health = clamp(health, 0, max_health)
	$Camera2D/CanvasLayer/Control/HealthCounter/Label.text = str(health)
	
	island_health = clamp(island_health, 0, island_max_health)
	$Camera2D/CanvasLayer/Control/IslandCounter/Label.text = str(island_health)
		
	#FIRING
	if can_fire:
		if Input.is_action_pressed("ui_mouse_left") and cannonball > 0:
			if round($cCoolDown.time_left) == 0:
				fire()
				$cCoolDown.set_wait_time(cooldown)
				$cCoolDown.start()
				
	#DEATH
	if health <= 0:
		on_death()

				
func _physics_process(delta):
	if Input.is_action_pressed("ui_select"):
		MAX_SPEED = 100
	else:
		MAX_SPEED = 40
	#USER INPUT
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	#SET ANIMATION
	if input_vector.x != 0:
		animationTree.set("parameters/Idle/blend_position", input_vector.x)
		animationTree.set("parameters/Move/blend_position", input_vector.x)
		animationState.travel("Move")
	
	#MOVEMENT
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle") # Animation
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	velocity = move_and_slide(velocity)
	
	
	if Input.is_action_pressed("ui_select"):
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			var collider = collision.collider
			
			if collider.has_method("hit_enemy"):
				collider.hit_enemy(3)
				$Camera2D/ScreenShake.start(0.2, 30, 1, 0)
				health -= 1
				$Rammed.play()
			
				
func fire():
	var cb_instance = CANNONBALL_SCENE.instance()
	cb_instance.position = get_global_position()
	cb_instance.life(.6)
	get_parent().add_child(cb_instance)
	cannonball -= 1
	$Camera2D/ScreenShake.start(0.2, 30, 0.5, 0)
	$CannonFire.play()
	
func collect_coins():
	gold += 5
	
func open_menu():
	$Camera2D/CanvasLayer/Control/NinePatchRect.visible = true
	can_fire = false

func close_menu():
	$Camera2D/CanvasLayer/Control/NinePatchRect.visible = false
	can_fire = true

func _on_Cannonball_pressed():
	if gold >= cannonball_cost:
		gold -= cannonball_cost
		cannonball += 10

func hit():
	health -= 1

func im_player():
	pass

func _on_Repair_pressed():
	if gold >= repair_cost and health < max_health:
		gold -= repair_cost
		health += 1

func on_death():
	emit_signal("death")


func _on_HomeIsland_hit():
	island_health -= 1
