extends Control

const MAIN_MENU = Vector2.ZERO
const OPTIONS_MENU = Vector2(1152, 0)
const TITLE_MENU = Vector2(-1152, 0)

var current_menu = "main"
var destination_menu = "main"
var destination_position = Vector2.ZERO

@onready var camera: Camera2D = $/root/Menu/Camera2D
@onready var sound_options = $Options/NinePatchRect/VBox/Center/Tabs/Sound
@onready var graphics_options = $Options/NinePatchRect/VBox/Center/Tabs/Graphics

func _ready():
	var config = ConfigFile.new()
	
	var err = config.load("user://options.cfg")

	if err:
		return
		
	sound_options.loadData(config)
	graphics_options.loadData(config)

func _physics_process(delta):
	if Input.is_action_just_pressed("escape"):
		destination_position = MAIN_MENU
	
	if camera.position == destination_position:
		return

	camera.position = lerp(camera.position, destination_position, 0.05)

func _on_options_pressed():
	destination_position = OPTIONS_MENU

func _on_options_back_pressed():
	var config = ConfigFile.new()
	
	sound_options.saveData(config)
	graphics_options.saveData(config)
	
	config.save("user://options.cfg")

	destination_position = MAIN_MENU

func _on_titles_pressed():
	destination_position = TITLE_MENU

func _on_titles_back_pressed():
	destination_position = MAIN_MENU

func _on_exit_pressed():
	get_tree().quit()
