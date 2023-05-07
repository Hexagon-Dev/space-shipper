extends RigidBody2D

@export var max_mass: int
@export var min_mass: int
var scale_value
var velocity = Vector2()

func _ready():
	mass = randi_range(min_mass, max_mass)
	scale_value = ((min_mass + max_mass) / 2) / mass
	
	var velocity = 100 / scale_value;
	
	#set_linear_velocity(Vector2(randi_range(velocity * -1, velocity), randi_range(velocity * -1, velocity)))

func _process(delta):
	if $Label != null:
		$Label.text = str(mass)
		
func _integrate_forces(state):
	for col in get_colliding_bodies():
		if col is RigidBody2D:
			var force = (col.linear_velocity - linear_velocity).length()
			var damage = col.mass / 100 * force / 10
			
			if mass - damage <= 0:
				print("Destroyed by: ", col.name)
				queue_free()
			else:
				mass -= damage
			
