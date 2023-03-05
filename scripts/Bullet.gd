extends RigidBody2D

func _process(_delta):
	await get_tree().create_timer(10).timeout
	queue_free()
