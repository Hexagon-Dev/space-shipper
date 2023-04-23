extends Node2D

@export var loading: bool = false
@export var pos: Vector2 = Vector2.ZERO
@export var radius: int = 50
var loading_rotation = 0
var screen = DisplayServer.window_get_size()

var calculated_position

func _ready():
	calculated_position = Vector2(pos.x, pos.y)

func _process(_delta):
	queue_redraw()

func _draw():
	if loading:
		if loading_rotation >= 360:
			loading_rotation = 0
		
		loading_rotation += 2

		draw_arc(calculated_position, radius, 0, deg_to_rad(360), 100, Color.WHITE, 10, true)
		draw_arc(calculated_position, radius, deg_to_rad(0 + loading_rotation), deg_to_rad(90 + loading_rotation), 100, Color("#828A76"), 10, true)
