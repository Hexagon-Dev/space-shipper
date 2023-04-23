class_name BasicBullet extends RigidBody2D

var damage_amount = 0

func _process(_delta):
	if get_colliding_bodies().size() > 0:
		processCollision()
	
	await get_tree().create_timer(10).timeout
	queue_free()

func processCollision():
	if "Bullet" in get_colliding_bodies()[0].name:
		return
	
	if get_colliding_bodies()[0].name == "CharacterBody2D":
		get_colliding_bodies()[0].damage(self)
	else:
		get_colliding_bodies()[0].queue_free()
	$Fire.emitting = true
	$Smoke.emitting = true
	if $Sprite2D:
		$Sprite2D.queue_free()
	if $CollisionShape2D:
		$CollisionShape2D.queue_free()
	await get_tree().create_timer(3).timeout
	queue_free()
