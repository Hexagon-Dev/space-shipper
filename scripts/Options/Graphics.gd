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
	for fps in fps_limits:
		max_fps.add_item(str(fps))
	
	var screen_size = DisplayServer.screen_get_size()

	var resolutions = []
	
	# Check which resolutions are supported and add them
	for resolution in display_resolutions:
		if resolution.x <= screen_size.x || resolution.y <= screen_size.y:
			resolutions.push_back(resolution)
	
	display_resolutions = resolutions
	
	for resolution in display_resolutions:
		resolution_dropdown.add_item(str(resolution.x) + "X" + str(resolution.y))
		
	var window_mode_value = Config.config.get_value("graphics", "window_mode")

	if window_mode_value != null:
		_on_select_window_mode_item_selected(window_mode_value)
		window_mode.select(window_mode_value)
	
	var resolution_value = Config.config.get_value("graphics", "resolution")
	
	if resolution_value != null && window_mode_value == 2:
		var key = getResolutionKey(resolution_value)
		_on_select_resolution_item_selected(key)
		resolution_dropdown.select(key)
	
	var vsync_value = Config.config.get_value("graphics", "vsync")
	
	if vsync_value != null:
		_on_select_vsync_item_selected(vsync_value)
		vsync.selected = vsync_value
	else:
		vsync.select(DisplayServer.window_get_vsync_mode())
	
	var max_fps_value = Config.config.get_value("graphics", "max_fps")

	if max_fps_value != null:
		var index = fps_limits.find(max_fps_value, 0)
	
		if index != null:
			_on_select_max_fps_item_selected(index)
			max_fps.select(index)
	else:
		Engine.max_fps = int(DisplayServer.screen_get_refresh_rate())
		max_fps.select(fps_limits.find(Engine.max_fps, 0))

func _on_select_resolution_item_selected(index):
	DisplayServer.window_set_size(display_resolutions[index])
	Config.config.set_value("graphics", "resolution", index)
	var display = DisplayServer.window_get_size()
	Config.config.set_value("graphics", "resolution", str(display.x) + "X" + str(display.y))

func getResolutionKey(cur_resolution: String):
	for i in range(display_resolutions.size()):
		var resolution = display_resolutions[i]
		if int(resolution.x) == int(cur_resolution.split('X')[0]) && int(resolution.y) == int(cur_resolution.split('X')[1]):
			return i
			
	return null

func _on_select_window_mode_item_selected(index):
	resolution_dropdown.disabled = index != 2
	
	DisplayServer.window_set_mode(window_modes[index])
	Config.config.set_value("graphics", "window_mode", index)
	var display = DisplayServer.window_get_size()
	Config.config.set_value("graphics", "resolution", str(display.x) + "X" + str(display.y))

	# for statement needed to match resolution in select with user screen
	for i in range(display_resolutions.size()):
		var resolution = display_resolutions[i]
		if resolution.x == display.x && resolution.y == display.y:
			resolution_dropdown.select(i)
			return
			
	display_resolutions.push_back(display)
	resolution_dropdown.add_item(str(display.x) + "X" + str(display.y))
	resolution_dropdown.select(display_resolutions.size() - 1)

func _on_select_vsync_item_selected(index):
	DisplayServer.window_set_vsync_mode(index)
	Config.config.set_value("graphics", "vsync", index)

func _on_select_max_fps_item_selected(index):
	Engine.max_fps = fps_limits[index]
	Config.config.set_value("graphics", "max_fps", Engine.max_fps)
