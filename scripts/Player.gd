extends BasicShip

var particles_flying
var reload_timer
var bullet_obj

const bullet = preload("res://objects/Bullet.tscn")

func _ready():
	bullet_obj = bullet.instantiate()
	reload_timer = $Reload
	particles_flying = $CollisionPolygon2D/GPUParticles2DFlying
	particles_flying.amount = player_speed * 1000 * weight / 20
	$CollisionPolygon2D/GPUParticles2DIdle.amount = weight / 20

func _process(_delta):
	queue_redraw()

func _physics_process(_delta):
	var mouse = get_global_mouse_position()
	
	if Input.is_action_pressed("left_click"):
		velocity += (mouse - global_position).limit_length(300) * (player_speed)
		
		fuel -= fuel_consumption
		
		if particles_flying.emitting != true:
			particles_flying.emitting = true
	else:
		if particles_flying.emitting != false:
			particles_flying.emitting = false
	
	$CollisionPolygon2D.rotation = lerp_angle($CollisionPolygon2D.rotation, (get_global_mouse_position() - global_position).normalized().angle() + (PI / 2), rotation_weight)
	velocity *= 0.99
	move_and_slide()

	if Input.is_action_pressed("right_click"):
		if (reload_timer.time_left > 0):
			return
			
		for point in $CollisionPolygon2D/ShootingPoints.get_children():
			if (bullets <= 0):
				return
			var b = bullet.instantiate()
			$/root/Game.add_child(b)
			#b.add_collision_exception_with(self)
			b.global_position = point.get_global_position()
			#b.rotation_degrees = $CollisionPolygon2D.rotation_degrees
			b.apply_central_impulse(Vector2(bullet_speed, 0).rotated($CollisionPolygon2D.rotation - PI / 2))
			bullets -= 1

			reload_timer.start(bullets_fire_speed)
			
	displayInterface()
	
func displayInterface():
	$Camera2D/Interface/Ammo.text = "Ammo: " + str(bullets) + "/" + str(max_bullets) + " (" + str("%1.3f" % reload_timer.time_left) + ")"
	$Camera2D/Interface/Fuel.text = "Fuel: " + str("%1.3f" % fuel) + "/" + str(max_fuel) + " (" + str(fuel_consumption) + ")"
	$Camera2D/Interface/Health.text = "Healt: " + str(health) + "/" + str(max_health)
	
func _draw():
	draw_line(Vector2.ZERO, velocity, Color(1,1,1), 3)
