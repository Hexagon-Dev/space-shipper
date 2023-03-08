extends CanvasLayer

var player
var screen_size
var icon

func _ready():
	player = $/root/Game/CharacterBody2D
	screen_size = $/root/Game.get_viewport_rect().size
	icon = $PlayerStats/Margin/Cols/Ammo/Reload/Icon

func _process(delta):
	$PlayerStats/Margin/Cols/Ammo/Text.text = str(player.current_weapon.bullets) + "/" + str(player.current_weapon.max_bullets)
	$PlayerStats/Margin/Cols/Fuel/Text.text = str("%1.2f" % player.fuel) + "/" + str(player.max_fuel)
	$PlayerStats/Margin/Cols/Health/Text.text = str("%1.1f" % player.health) + "/" + str(player.max_health)
	
	if (player.current_weapon.reloading && !icon.visible):
		icon.visible = true
	elif (!player.current_weapon.reloading && icon.visible):
		icon.visible = false
	
	if !$WeaponSelector:
		var container = Node2D.new()
		container.name = 'WeaponSelector'
		container.scale = Vector2(2, 2)
		container.position = Vector2(screen_size.x / 2, screen_size.y)
		add_child(container)
		for weapon in player.weapons:
			var cell = Sprite2D.new()
			cell.position.y -= 25
			var texture = Texture2D.new()
			texture = load('res://textures/inv_cell.png')
			cell.texture = texture
			cell.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST_WITH_MIPMAPS
			$WeaponSelector.add_child(cell)
