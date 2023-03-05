extends Sprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	position = lerp(position, get_global_mouse_position(), 0.02)
	
