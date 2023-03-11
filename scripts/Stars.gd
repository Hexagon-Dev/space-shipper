extends ColorRect

var player: BasicShip
@export var camera: Camera2D
@export var is_menu: bool = false
var scene_position = Vector2.ZERO

func _ready():
	if !is_menu:
		player = $/root/Game/CharacterBody2D
	
	var rng = RandomNumberGenerator.new()
	# TODO: Set seed from save
	rng.seed = hash(randi_range(0, 1000)) if is_menu else hash(1111)
	var displacement = rng.randf_range(0, 6000)
	print(displacement)
	material.set_shader_parameter("viewport_size", get_viewport_rect().size)
	material.set_shader_parameter("displacement", Vector2(displacement, displacement))

func _process(_delta):
	if is_menu:
		scene_position += Vector2.UP
		material.set_shader_parameter("player_position", Vector2(camera.position.x, scene_position.y))
	else:
		material.set_shader_parameter("player_position", player.position)
