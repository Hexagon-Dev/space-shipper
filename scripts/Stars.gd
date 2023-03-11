extends ColorRect

var player

#func _process(delta):
	#position = $/root/Game/CharacterBody2D.position

func _ready():
	player = $/root/Game/CharacterBody2D
	material.set_shader_parameter("viewport_size", get_viewport_rect().size)

func _process(delta):
	#position = player.position
	material.set_shader_parameter("player_position", player.position)
