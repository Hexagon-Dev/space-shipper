extends Sprite2D

var white = Color('#fff')
var red = Color('#ff0000')

func _process(_delta):
	position = lerp(position, get_global_mouse_position(), 0.02)
	if ($/root/Game/CharacterBody2D.current_weapon.reloading && modulate != red):
		modulate = red
	elif (!$/root/Game/CharacterBody2D.current_weapon.reloading && modulate != white):
		modulate = white
	
