extends Control

@export var loading: bool = false
var time: float

func _ready():
	Globals.connect("pending_events_changed", Callable(self, "on_pending_events_changed"))
	
func on_pending_events_changed():
	print("pending_events_changed")
	loading = Globals.getPendingEvents(["loading", "saving"]).size() > 0

func _process(delta):
	if self.visible != loading:
		self.visible = loading
	
	if loading:
		time += delta * 2
		self.modulate = Color(255, 255, 255, abs(sin(time)))
		$Label.text = str(sin(time))
	elif time != 0:
		time = 0
