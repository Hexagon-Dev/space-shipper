extends TabBar

var buses = ["Master", "Music", "Ambient", "Sounds"]

func loadData(config):
	AudioServer.bus_count
	
	for bus in buses:
		var value = config.get_value("sound", bus)
		
		if value:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus), value)
			get_node('Margin/VBox/' + bus + '/Margin/Value').text = str(100 - int(value / -80 * 100)) + "%"
			get_node('Margin/VBox/' + bus + '/Volume').set_value_no_signal(value)

func saveData(config: ConfigFile):
	for bus in buses:
		config.set_value("sound", bus, AudioServer.get_bus_volume_db(AudioServer.get_bus_index(bus)))

func _on_master_volume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	$Margin/VBox/Master/Margin/Value.text = str(100 - int(value / -80 * 100)) + "%"

func _on_music_volume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
	$Margin/VBox/Music/Margin/Value.text = str(100 - int(value / -80 * 100)) + "%"

func _on_ambient_volume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Ambient"), value)
	$Margin/VBox/Ambient/Margin/Value.text = str(100 - int(value / -80 * 100)) + "%"

func _on_sound_volume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sounds"), value)
	$Margin/VBox/Sounds/Margin/Value.text = str(100 - int(value / -80 * 100)) + "%"
