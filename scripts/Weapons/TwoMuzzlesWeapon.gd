extends BasicWeapon

func _ready():
	type = "TwoMuzzlesWeapon"
	rocket = preload("res://objects/bullets/Rocket.tscn")
	bullet_mass = 10
