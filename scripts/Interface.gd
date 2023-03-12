extends CanvasLayer

var player
var screen_size
var icon
var block = StyleBoxFlat.new()
var block_active = StyleBoxFlat.new()
var style: Theme = load('res://styles/main_ui.tres')
var active_style: Theme = load('res://styles/main_ui_active.tres')

func _ready():
	screen_size = $/root/Game.get_viewport_rect().size
	icon = $PlayerStats/Margin/Cols/Ammo/Reload/Icon
	block.bg_color = Color.WHITE
	block_active.bg_color = Color.RED
	player = $/root/Game/CharacterBody2D
	
func initWeaponsUI():
	for i in len(player.weapons):
		var weapon = player.weapons[i]
		print(weapon.type)
		var cell = Panel.new()
		cell.name = weapon.type
		var text = RichTextLabel.new()
		text.text = str(i + 1)
		text.custom_minimum_size = Vector2(100, 100)
		text.position = Vector2(10, 10)
		cell.add_child(text)
		cell.scale = Vector2(2, 2)
		cell.theme = style
		cell.custom_minimum_size = Vector2(80, 80)
		$WeaponContainer/HBox.add_child(cell)

func _process(_delta):
	$Debug.text = "FPS: " + str(Engine.get_frames_per_second())
	
	# TODO: Refactor bullets changing
	if (player.current_weapon.bullets):
		$PlayerStats/Margin/Cols/Ammo/Text.text = str(player.current_weapon.bullets) + "/" + str(player.current_weapon.max_bullets)
		$PlayerStats/Margin/Cols/Ammo/Text.custom_minimum_size = Vector2(120, 16)
		$PlayerStats/Margin/Cols/Ammo/Infinity.visible = false
	else:
		$PlayerStats/Margin/Cols/Ammo/Text.text = ""
		$PlayerStats/Margin/Cols/Ammo/Text.custom_minimum_size = Vector2(0, 0)
		$PlayerStats/Margin/Cols/Ammo/Infinity.visible = true
	$PlayerStats/Margin/Cols/Fuel/Text.text = str("%1.2f" % player.fuel) + "/" + str(player.max_fuel) + " " + str("%1.3f" % player.fuel_consumption)
	$PlayerStats/Margin/Cols/Health/Text.text = str("%1.1f" % player.health) + "/" + str(player.max_health)
	
	if (player.current_weapon.reloading && !icon.visible):
		icon.visible = true
	elif (!player.current_weapon.reloading && icon.visible):
		icon.visible = false

	for weapon in player.weapons:
		var node: Panel = get_node("WeaponContainer/HBox/" + weapon.type)
		if !node:
			return

		# TODO: Refactor acive weapon highlight
		if player.current_weapon.type == weapon.type:
			if node.theme != active_style:
				node.theme = active_style
		else:
			if node.theme != style:
				node.theme = style
			#node.theme.set_stylebox('panel', 'Panel', block)
