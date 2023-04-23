extends Control

const MAIN_MENU = Vector2.ZERO
const OPTIONS_MENU = Vector2(1152, 0)
const TITLE_MENU = Vector2(-1152, 0)
const SINGLE_MENU = Vector2(0, -720)
const CREATE_MENU = Vector2(0, -1440)

var destination_position = Vector2.ZERO

@onready var camera: Camera2D = $/root/Menu/Camera2D
@onready var sound_options = $Options/NinePatchRect/VBox/Center/Tabs/Sound
@onready var graphics_options = $Options/NinePatchRect/VBox/Center/Tabs/Graphics
@onready var loader = $/root/Menu/Camera2D/Loading

var world = preload("res://game.tscn")
var world_button = preload("res://objects/WorldButton.tscn")
var selected_world

var difficulties = ["Easy", "Medium", "Hard", "Hell"]

@export var worlds_button_group: ButtonGroup

func _ready():
	$Main/NPR/Version.text = Globals.version
	
	loader.loading = true
	
	var config = ConfigFile.new()
	
	var err = config.load("user://options.cfg")

	if err:
		loader.loading = false
		return
		
	sound_options.loadData(config)
	graphics_options.loadData(config)
	
	loader.loading = false

	for save in DirAccess.get_files_at("user://worlds/"):
		var save_game = FileAccess.open("user://worlds/" + save, FileAccess.READ)
		
		if !save_game:
			continue
		
		var seed = save_game.get_32()
		var world_data = save_game.get_var()
		var version = save_game.get_line()
		
		if seed == null || world_data == null:
			continue
		
		var btn = world_button.instantiate()
		btn.get_node("HBox/Data/WorldName").text = world_data.name
		btn.get_node("HBox/Data/PlayedAt").text = world_data.played_at
		btn.get_node("HBox/Data/Difficulty").text = difficulties[world_data.difficulty]
		$Single/NPR/VBox/Panel/Scroll/WorldList.add_child(btn)

func _process(delta):
	$Single/NPR/VBox/Control/Play.disabled = !selected_world
	$Single/NPR/VBox/Control/Delete.disabled = !selected_world
	$Single/NPR/VBox/Control/Rename.disabled = !selected_world
	selected_world = worlds_button_group.get_pressed_button()

func _physics_process(_delta):
	if Input.is_action_just_pressed("escape"):
		destination_position = MAIN_MENU
	
	if camera.position == destination_position:
		return

	camera.position = lerp(camera.position, destination_position, 0.05)

func _on_single_pressed():
	destination_position = SINGLE_MENU
	
func _on_options_pressed():
	destination_position = OPTIONS_MENU

func _on_options_back_pressed():
	loader.loading = true
	var config = ConfigFile.new()
	
	sound_options.saveData(config)
	graphics_options.saveData(config)
	
	config.save("user://options.cfg")

	destination_position = MAIN_MENU
	loader.loading = false

func _on_titles_pressed():
	destination_position = TITLE_MENU

func _on_titles_back_pressed():
	destination_position = MAIN_MENU

func _on_exit_pressed():
	get_tree().quit()

func _on_create_pressed():
	destination_position = CREATE_MENU

func _on_create_back_pressed():
	destination_position = SINGLE_MENU

# World creation

func _on_world_name_text_changed(new_text):
	$Create/NPR/VBox/Control/CreateWorld.disabled = new_text.length() == 0

func _on_create_world_pressed():
	var seed = randi_range(0, 1000000000)
	var world_data = {
		"name": $Create/NPR/VBox/Panel/Margin/VBox/WorldName.text,
		"difficulty": $Create/NPR/VBox/Panel/Margin/VBox/Difficulty.get_selected_id(),
		"allowed_cheats": $Create/NPR/VBox/Panel/Margin/VBox/AllowCheats.toggle_mode,
		"created_at": Time.get_datetime_string_from_system().replace("T", " "),
		"played_at": Time.get_datetime_string_from_system().replace("T", " "),
	}
	
	if !DirAccess.dir_exists_absolute("user://worlds/"):
		DirAccess.make_dir_absolute("user://worlds/")
	
	var save_game = FileAccess.open("user://worlds/" + world_data.name + ".save", FileAccess.WRITE)
	
	save_game.store_32(seed)
	save_game.store_var(world_data)
	save_game.store_line(Globals.version)
	save_game.close()
	
	start_game(world_data.name)

func start_game(save_name: String):
	destination_position = MAIN_MENU
	
	if not FileAccess.file_exists("user://worlds/" + save_name + ".save"):
		return
		
	var save_game = FileAccess.open("user://worlds/" + save_name + ".save", FileAccess.READ)
	
	var seed = save_game.get_32()
	var world_data = save_game.get_var()
	var world_instance = world.instantiate()

	world_instance.world_data = world_data
	world_instance.seed = seed
	get_tree().get_root().add_child(world_instance)
	$/root/Menu/Music.stop()
	$/root/Menu/Music.seek(0)
	$/root/Menu.visible = false
	$/root/Game/CharacterBody2D/Camera2D.make_current()
	$/root/Game/CharacterBody2D/StarsLayer/ColorRect.init_stars(seed)

func _on_play_pressed():
	if selected_world:
		start_game(selected_world.get_node("HBox/Data/WorldName").text)
