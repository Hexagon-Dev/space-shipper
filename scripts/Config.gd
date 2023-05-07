extends Node

var config: ConfigFile

var soundBuses = ["Master", "Music", "Ambient", "Sounds"]

func _ready():
	Globals.addPendingEvent("loading.config", true)
	
	config = ConfigFile.new()
	
	config.load("user://options.cfg")
	
	loadSoundOptions()
	
	Globals.removePendingEvent("loading.config")
	
	
func loadSoundOptions():
	for bus in soundBuses:
		var value = config.get_value("sound", bus)
		
		if value:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus), value)
	
func save():
	Globals.addPendingEvent("saving.config", true)
	
	config.save("user://options.cfg")
	
	Globals.removePendingEvent("saving.config")
	
