extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_GoldCoin_body_entered(body):
	if body.has_method("collect_coins"):
		body.collect_coins()
		queue_free()
