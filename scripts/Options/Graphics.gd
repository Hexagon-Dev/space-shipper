extends TabBar

var display_resolutions = [
	Vector2(1280, 720),
	Vector2(1366, 768),
	Vector2(1600, 900),
	Vector2(1920, 1080),
	Vector2(2560, 1440),
	Vector2(3200, 1800),
	Vector2(3840, 2160),
]

const window_modes = [
	DisplayServer.WINDOW_MODE_FULLSCREEN,
	DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN,
	DisplayServer.WINDOW_MODE_WINDOWED,
]

const fps_limits = [30, 60, 75, 120, 144, 165, 240]

@onready var resolution_dropdown = $Margin/VBox/Resolution/SelectResolution
@onready var window_mode = $Margin/VBox/WindowMode/SelectWindowMode
@onready var vsync = $Margin/VBox/VSync/SelectVsync
@onready var max_fps = $Margin/VBox/MaxFPS/SelectMaxFPS

func _ready():
	Engine.max_fps = DisplayServer.screen_get_refresh_rate()
	vsync.select(DisplayServer.window_get_vsync_mode())
	
	for fps in fps_limits:
		max_fps.add_item(str(fps))
		
	max_fps.select(fps_limits.find(Engine.max_fps, 0))
	
	var screen_size = DisplayServer.screen_get_size()

	var resolutions = []
	
	# Check which resolutions are supported and add them
	for resolution in display_resolutions:
		if resolution.x <= screen_size.x || resolution.y <= screen_size.y:
			resolutions.push_back(resolution)
	
	display_resolutions = resolutions
	
	for resolution in display_resolutions:
		resolution_dropdown.add_item(str(resolution.x) + "×" + str(resolution.y))

func _on_select_resolution_item_selected(index):
	DisplayServer.window_set_size(display_resolutions[index])

func _on_select_window_mode_item_selected(index):
	DisplayServer.window_set_mode(window_modes[index])
	var display = DisplayServer.window_get_size()

	for i in range(display_resolutions.size()):
		var resolution = display_resolutions[i]
		print(resolution.x, "-", display.x, " | ", resolution.y, "-", display.y)
		if resolution.x == display.x && resolution.y == display.y:
			resolution_dropdown.select(i)
			return
			
	display_resolutions.push_back(display)
	resolution_dropdown.add_item(str(display.x) + "×" + str(display.y))
	resolution_dropdown.select(display_resolutions.size() - 1)

func _on_select_vsync_item_selected(index):
	DisplayServer.window_set_vsync_mode(index)

func _on_select_max_fps_item_selected(index):
	Engine.max_fps = fps_limits[index]
