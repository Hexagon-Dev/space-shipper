extends Node2D

const asteroid = preload("res://objects/Asteroid.tscn")
var asteroid_obj
# Called when the node enters the scene tree for the first time.
func _ready():
	var count = randi_range(30, 50)
	
	for item in count:
		asteroid_obj = asteroid.instantiate()
		add_child(asteroid_obj)
		asteroid_obj.position = Vector2(randi_range(-1000, 1000), randi_range(-1000, 1000))
