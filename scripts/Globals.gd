extends Node

var version: String = "0.0.2"

var pending_events = {}

signal pending_events_changed

func addPendingEvent(key, value) -> void:
	pending_events[key] = value
	emit_signal("pending_events_changed")
	
func removePendingEvent(key) -> void:
	pending_events.erase(key)
	emit_signal("pending_events_changed")

func getPendingEvents(keys = null) -> Dictionary:
	if keys == null:
		return pending_events
		
	if typeof(keys) == TYPE_STRING:
		keys = [keys]
	
	var values = {};
	
	for key in keys:
		for value in pending_events:
			if key in value:
				values[value] = pending_events[value]
			
	return values
