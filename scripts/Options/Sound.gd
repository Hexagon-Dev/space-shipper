extends TabBar

@onready var master_value = $Margin/VBox/Master/Margin/Value
@onready var music_value = $Margin/VBox/Music/Margin/Value
@onready var ambient_value = $Margin/VBox/Ambient/Margin/Value
@onready var sounds_value = $Margin/VBox/Sounds/Margin/Value

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
