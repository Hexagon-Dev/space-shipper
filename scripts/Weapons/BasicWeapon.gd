class_name BasicWeapon extends Node2D

var max_bullets = 40
var bullets = max_bullets
# per second
var bullets_fire_speed = 1
var bullet_speed = 400
var reloading = false
var cursor
var rocket = preload("res://objects/Rocket.tscn")
var weaponOwner: RigidBody2D
var type = "BasicWeapon"

func _ready():
	cursor = $/root/Game/CharacterBody2D/Camera2D/Interface/Cursor

func _process(_delta):
	if Input.is_action_pressed("right_click"):
		if (reloading):
			return
		for point in self.get_children():
			if (weaponOwner.current_weapon.type != type || (bullets != null && bullets <= 0)):
				return
			var b = rocket.instantiate()
			$/root/Game.add_child(b)
			b.global_position = point.get_global_position()
			b.look_at(get_global_mouse_position())
			b.add_collision_exception_with(weaponOwner)
			var velocity = (b.global_position - get_global_mouse_position()).normalized() * bullet_speed
			
			b.linear_velocity = -velocity
			weaponOwner.apply_impulse(velocity * 10)
			if bullets:
				bullets -= 1
		reloading = true
		await get_tree().create_timer(bullets_fire_speed).timeout
		reloading = false
