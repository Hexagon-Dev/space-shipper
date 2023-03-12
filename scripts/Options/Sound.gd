extends TabBar

@onready var master_value = $Margin/VBox/Master/Margin/Value
@onready var music_value = $Margin/VBox/Music/Margin/Value
@onready var ambient_value = $Margin/VBox/Ambient/Margin/Value
@onready var sounds_value = $Margin/VBox/Sounds/Margin/Value

func _ready():
	var config = ConfigFile.new()
	
	var err = config.load("user://options.cfg")

	if err:
		return
	
	var master_volume = config.get_value("sound", "master_volume")
	var music_volume = config.get_value("sound", "music_volume")
	var ambient_volume = config.get_value("sound", "ambient_volume")
	var sounds_volume = config.get_value("sound", "sounds_volume")

	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), master_volume)
	master_value.text = str(100 - int(master_volume / -80 * 100)) + "%"
	$Margin/VBox/Master/MasterVolume.set_value_no_signal(master_volume)
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), music_volume)
	music_value.text = str(100 - int(music_volume / -80 * 100)) + "%"
	$Margin/VBox/Music/MusicVolume.set_value_no_signal(music_volume)
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Ambient"), ambient_volume)
	ambient_value.text = str(100 - int(ambient_volume / -80 * 100)) + "%"
	$Margin/VBox/Ambient/AmbientVolume.set_value_no_signal(ambient_volume)
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sounds"), sounds_volume)
	sounds_value.text = str(100 - int(sounds_volume / -80 * 100)) + "%"
	$Margin/VBox/Sounds/SoundVolume.set_value_no_signal(sounds_volume)

func save():
	var config = ConfigFile.new()
	
	config.set_value("sound", "master_volume", AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	config.set_value("sound", "music_volume", AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	config.set_value("sound", "ambient_volume", AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Ambient")))
	config.set_value("sound", "sounds_volume", AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Sounds")))
	
	config.save("user://options.cfg")

func _on_master_volume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	master_value.text = str(100 - int(value / -80 * 100)) + "%"

func _on_music_volume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
	music_value.text = str(100 - int(value / -80 * 100)) + "%"

func _on_ambient_volume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Ambient"), value)
	ambient_value.text = str(100 - int(value / -80 * 100)) + "%"

func _on_sound_volume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sounds"), value)
	sounds_value.text = str(100 - int(value / -80 * 100)) + "%"
