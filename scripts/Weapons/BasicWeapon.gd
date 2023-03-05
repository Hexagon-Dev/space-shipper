class_name BasicWeapon extends Node2D

var max_bullets = 40
var bullets = max_bullets
# per second
var bullets_fire_speed = 1
var bullet_speed = 400
var reloading = false

const bullet = preload("res://objects/Bullet.tscn")

func _process(delta):
	if Input.is_action_pressed("right_click"):
		if (reloading):
			return
		for point in self.get_children():
			if (bullets <= 0):
				return
			var b = bullet.instantiate()
			$/root/Game.add_child(b)
			b.global_position = point.get_global_position()
			# b.rotation_degrees = $CollisionPolygon2D.rotation_degrees
			var player = $/root/Game/CharacterBody2D
			b.apply_central_impulse(Vector2(bullet_speed, 0).rotated(player.rotation - PI / 2))
			bullets -= 1
		reloading = true
		await get_tree().create_timer(bullets_fire_speed).timeout
		reloading = false
