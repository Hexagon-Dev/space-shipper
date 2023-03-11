extends BasicShip

var particles_flying
var velocity = Vector2.ZERO

const TwoMuzzlesWeapon = preload("res://objects/weapons/TwoMuzzlesWeapon.tscn")
const MachineGunWeapon = preload("res://objects/weapons/MachineGunWeapon.tscn")

func _ready():
	var two_muzzles_weapon = TwoMuzzlesWeapon.instantiate()
	var machine_gun_weapon = MachineGunWeapon.instantiate()
	two_muzzles_weapon.weaponOwner = self
	machine_gun_weapon.weaponOwner = self
	$Player/Weapons.add_child(two_muzzles_weapon)
	$Player/Weapons.add_child(machine_gun_weapon)	
	weapons = $Player/Weapons.get_children()
	current_weapon = weapons[0]
	particles_flying = $Player/GPUParticles2DFlying
	particles_flying.amount = player_speed * mass / 20
	$Player/GPUParticles2DIdle.amount = int(mass / 20)
	$Camera2D/Interface.initWeaponsUI()

func _process(delta):
	for i in len(weapons):
		if Input.is_action_just_pressed('number_' + str(i + 1)):
			current_weapon = weapons[i]

func _integrate_forces(state):
	mass = basic_weight + storage + fuel
	fuel_consumption = player_speed * mass / 30000000000
	
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

	apply_force(velocity.rotated(rotation - PI / 2))
	apply_torque(Input.get_axis("arrow_left", "arrow_right") * player_speed * 100)

	velocity *= 0.98
	
	for col in get_colliding_bodies():
		if col is RigidBody2D:
			if col.name.contains('Asteroid'):
				var damage = col.mass / mass
				$Camera2D.add_trauma(damage * 20)
				health -= damage

func damage(source):
	health -= source.damage_amount
