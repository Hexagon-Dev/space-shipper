extends BasicShip

var particles_flying

const TwoMuzzlesWeapon = preload("res://objects/TwoMuzzlesWeapon.tscn")

func _ready():
	var two_muzzles_weapon = TwoMuzzlesWeapon.instantiate()
	two_muzzles_weapon.setTarget(self)
	$CollisionPolygon2D/Weapons.add_child(two_muzzles_weapon)
	weapons = $CollisionPolygon2D/Weapons.get_children()
	current_weapon = weapons[0]
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
	
func _draw():
	draw_line(Vector2.ZERO, velocity, Color(1,1,1), 3)
