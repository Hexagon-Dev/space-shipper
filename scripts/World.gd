extends Node2D

var rng: RandomNumberGenerator
@export var world_data: Dictionary
var seed

var asteroids = []

func _ready():
	var path = "res://objects/asteroids"
	var dir = DirAccess.open(path)
	dir.list_dir_begin()
	while true:
		var file_name = dir.get_next()
		if file_name == "":
			break
		elif !file_name.begins_with("."):
			asteroids.append(load(path + "/" + file_name))

	dir.list_dir_end()
	
	rng = RandomNumberGenerator.new()
	rng.seed = hash(world_data if seed else 1)
	var count = randi_range(30, 50)
	
	for item in count:
		var asteroid_obj = asteroids[randi() % asteroids.size()].instantiate()
		add_child(asteroid_obj)
		asteroid_obj.position = Vector2(randi_range(-1000, 1000), randi_range(-1000, 1000))
		asteroid_obj.rotation = randi()

func save():
	if not FileAccess.file_exists("user://worlds/" + world_data.name + ".save"):
		return
		
	var save_game = FileAccess.open("user://worlds/" + world_data.name + ".save", FileAccess.WRITE)
	
	save_game.store_32(randi_range(0, 1000000000))
	save_game.store_var(world_data)
	save_game.store_line(Globals.version)
	save_game.store_var($CharacterBody2D)
	save_game.close()
