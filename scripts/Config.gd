extends Node

var config

func _ready():
	Globals.addPendingEvent("loading.config", true)
	
	config = ConfigFile.new()
	
	config.load("user://options.cfg")
	
	Globals.removePendingEvent("loading.config")
	
	
func save():
	Globals.addPendingEvent("saving.config", true)
	
	config.save("user://options.cfg")
	
	Globals.removePendingEvent("saving.config")
	
