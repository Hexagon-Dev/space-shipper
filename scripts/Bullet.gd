extends RigidBody2D

var damage_amount = 5

func _process(_delta):
	if get_colliding_bodies().size() > 0:
		print(get_colliding_bodies()[0].name)
		if get_colliding_bodies()[0].name == "CharacterBody2D":
			get_colliding_bodies()[0].damage(self)
		else:
			get_colliding_bodies()[0].queue_free()
		queue_free()
	
	await get_tree().create_timer(10).timeout
	queue_free()
