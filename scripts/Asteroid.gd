extends RigidBody2D

func _ready():
	set_linear_velocity(Vector2(randi_range(-100, 100), randi_range(-100, 100)))
