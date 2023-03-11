extends ColorRect

var player

#func _process(delta):
	#position = $/root/Game/CharacterBody2D.position

func _ready():
	player = $/root/Game/CharacterBody2D
	
	var rng = RandomNumberGenerator.new()
	rng.seed = hash(1111)
	var displacement = rng.randf_range(0, 6000)
	print(displacement)
	material.set_shader_parameter("viewport_size", get_viewport_rect().size)
	material.set_shader_parameter("displacement", Vector2(displacement, displacement))

func _process(delta):
	#position = player.position
	material.set_shader_parameter("player_position", player.position)
