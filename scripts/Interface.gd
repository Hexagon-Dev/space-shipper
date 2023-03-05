extends CanvasLayer

var player
var screen_size

func _ready():
	player = $/root/Game/CharacterBody2D
	screen_size = $/root/Game.get_viewport_rect().size

func _process(delta):
	$Ammo.text = "Ammo: " + str(player.current_weapon.bullets) + "/" + str(player.current_weapon.max_bullets) + " (" + str(player.current_weapon.reloading) + ")"
	$Fuel.text = "Fuel: " + str("%1.3f" % player.fuel) + "/" + str(player.max_fuel) + " (" + str(player.fuel_consumption) + ")"
	$Health.text = "Health: " + str(player.health) + "/" + str(player.max_health)
	
	if !$WeaponSelector:
		var container = Node2D.new()
		container.name = 'WeaponSelector'
		container.scale = Vector2(2, 2)
		container.position = Vector2(screen_size.x / 2, screen_size.y)
		add_child(container)
		for weapon in player.weapons:
			print(weapon.type)
			var cell = Sprite2D.new()
			cell.position.y -= 25
			var texture = Texture2D.new()
			texture = load('res://textures/inv_cell.png')
			cell.texture = texture
			cell.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST_WITH_MIPMAPS
			$WeaponSelector.add_child(cell)
