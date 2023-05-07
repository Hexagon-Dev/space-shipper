extends TabBar

func _ready():
	for bus in Config.soundBuses:
		var value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index(bus))
		
		if value:
			get_node('Margin/VBox/' + bus + '/Margin/Value').text = str(100 - int(value / -80 * 100)) + "%"
			get_node('Margin/VBox/' + bus + '/Volume').set_value_no_signal(value)

func _on_master_volume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	$Margin/VBox/Master/Margin/Value.text = str(100 - int(value / -80 * 100)) + "%"
	Config.config.set_value("sound", "Master", value)

func _on_music_volume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
	$Margin/VBox/Music/Margin/Value.text = str(100 - int(value / -80 * 100)) + "%"
	Config.config.set_value("sound", "Music", value)

func _on_ambient_volume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Ambient"), value)
	$Margin/VBox/Ambient/Margin/Value.text = str(100 - int(value / -80 * 100)) + "%"
	Config.config.set_value("sound", "Ambient", value)

func _on_sound_volume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sounds"), value)
	$Margin/VBox/Sounds/Margin/Value.text = str(100 - int(value / -80 * 100)) + "%"
	Config.config.set_value("sound", "Sounds", value)
