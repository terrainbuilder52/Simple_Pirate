extends YSort


onready var ISLAND_SCENE = preload("res://World/Islands/PirateIsland.tscn")
onready var island = null

func _ready():
	for i in range(3):
		if i == 0:
			island = ISLAND_SCENE.instance()
			island.position = $Island1.get_global_position()
			add_child(island)
		if i == 1:
			island = ISLAND_SCENE.instance()
			island.position = $Island2.get_global_position()
			add_child(island)
		if i == 2:
			island = ISLAND_SCENE.instance()
			island.position = $Island3.get_global_position()
			add_child(island)

