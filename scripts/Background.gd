extends Node2D

var debug = false
var player

func _ready():
	player = $/root/Game/CharacterBody2D

func _process(delta):
	if Input.is_action_just_pressed('f1'):
		debug = !debug
	queue_redraw()

func _draw():
	if (debug):
		draw_line(player.global_position, player.global_position + player.linear_velocity, Color.WHITE)
