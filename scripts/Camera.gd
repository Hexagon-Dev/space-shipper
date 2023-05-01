extends Camera2D

@export var decay = 0.7
@export var max_offset = Vector2(100, 75)  # Maximum hor/ver shake in pixels.
@export var max_roll = 0.1 # Maximum rotation in radians (use sparingly).
@export_node_path var target # Assign the node this camera will follow.

var trauma = 0.0  # Current shake strength.
var trauma_power = 2  # Trauma exponent. Use [2, 3].

func _ready():
	randomize()

func add_trauma(amount):
	if (trauma > 0):
		return
	trauma = min(trauma + amount, 1.0)

func shake():
	var amount = pow(trauma, trauma_power)
	rotation = max_roll * amount * randi_range(-1, 1)
	offset.x = max_offset.x * amount * randi_range(-1, 1)
	offset.y = max_offset.y * amount * randi_range(-1, 1)

func _process(delta):
	if target:
		global_position = get_node(target).global_position
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()
