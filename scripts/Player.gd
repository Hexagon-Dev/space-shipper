extends BasicShip

var particles_flying
var rotation_dir = 0
var spin_thrust = 2500

const TwoMuzzlesWeapon = preload("res://objects/TwoMuzzlesWeapon.tscn")

func _ready():
	var two_muzzles_weapon = TwoMuzzlesWeapon.instantiate()
	$Player/Weapons.add_child(two_muzzles_weapon)
	weapons = $Player/Weapons.get_children()
	current_weapon = weapons[0]
	particles_flying = $Player/GPUParticles2DFlying
	particles_flying.amount = player_speed * weight / 20
	$Player/GPUParticles2DIdle.amount = weight / 20

func _process(_delta):
	queue_redraw()

func _physics_process(_delta):
	var mouse = get_global_mouse_position()
	
	if Input.is_action_pressed("left_click"):
		velocity += (mouse - global_position).limit_length(300) * (player_speed / 1000)
		fuel -= fuel_consumption
		
		if particles_flying.emitting != true:
			particles_flying.emitting = true
	else:
		if particles_flying.emitting != false:
			particles_flying.emitting = false

	rotation = lerp_angle(rotation, (global_position - mouse).normalized().angle() - PI / 2, rotation_weight)
	
	velocity *= 0.98
	move_and_slide()
	
	for i in get_slide_collision_count():
		var col = get_slide_collision(i)
		if col.get_collider() is RigidBody2D:
			if col.get_collider().name.contains('Asteroid'):
				health -= 0.1
			col.get_collider().apply_force(col.get_normal() * -1000)

func damage(source):
	health -= source.damage_amount

func _draw():
	draw_line(Vector2.ZERO, velocity, Color(1,1,1), 3)
