extends Node2D

var rng: RandomNumberGenerator
@export var world_data: Dictionary
var seed

const asteroid = preload("res://objects/Asteroid.tscn")
var asteroid_obj

func _ready():
	rng = RandomNumberGenerator.new()
	rng.seed = hash(world_data if seed else 1)
	var count = randi_range(30, 50)
	
	for item in count:
		asteroid_obj = asteroid.instantiate()
		add_child(asteroid_obj)
		asteroid_obj.position = Vector2(randi_range(-1000, 1000), randi_range(-1000, 1000))

func save():
	if not FileAccess.file_exists("user://worlds/" + world_data.name + ".save"):
		return
		
	var save_game = FileAccess.open("user://worlds/" + world_data.name + ".save", FileAccess.WRITE)
	
	save_game.store_32(randi_range(0, 1000000000))
	save_game.store_var(world_data)
	save_game.store_line(Globals.version)
	save_game.store_var($CharacterBody2D)
	save_game.close()
