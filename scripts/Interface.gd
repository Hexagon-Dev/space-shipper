extends CanvasLayer

var player

func _ready():
	player = $/root/Game/CharacterBody2D

func _process(delta):
	$Ammo.text = "Ammo: " + str(player.current_weapon.bullets) + "/" + str(player.current_weapon.max_bullets) + " (" + str(player.current_weapon.reloading) + ")"
	$Fuel.text = "Fuel: " + str("%1.3f" % player.fuel) + "/" + str(player.max_fuel) + " (" + str(player.fuel_consumption) + ")"
	$Health.text = "Health: " + str(player.health) + "/" + str(player.max_health)
