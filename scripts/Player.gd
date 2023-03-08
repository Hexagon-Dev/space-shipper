extends BasicShip

var particles_flying
var rotation_dir = 0
var velocity = Vector2.ZERO

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
	$Camera2D/Interface/Canvas.queue_redraw()

func _integrate_forces(state):
	if Input.is_action_pressed("arrow_up"):
		fuel -= fuel_consumption
		velocity = lerp(velocity, Vector2(player_speed * 8, 0), 0.05)
		if particles_flying.emitting != true:
			particles_flying.emitting = true
	if Input.is_action_pressed("arrow_down"):
		fuel -= fuel_consumption
		velocity = lerp(velocity, Vector2(-player_speed * 8, 0), 0.05)
		if particles_flying.emitting != true:
			particles_flying.emitting = true

	if particles_flying.emitting != false:
			particles_flying.emitting = false

	rotation_dir = 0

	if Input.is_action_pressed("arrow_right"):
		rotation_dir += 1
	if Input.is_action_pressed("arrow_left"):
		rotation_dir -= 1

	apply_force(velocity.rotated(rotation - PI / 2))
	apply_torque(rotation_dir * player_speed * 100)

	velocity *= 0.98
	
	for col in get_colliding_bodies():
		if col is RigidBody2D:
			if col.name.contains('Asteroid'):
				print(str(col.linear_velocity))
				health -= 0.1

func damage(source):
	health -= source.damage_amount

func _draw():
	$Camera2D/Interface/Canvas.draw_line(Vector2.ZERO, to_global(velocity), Color(1,1,1), 3)
