class_name BasicShip extends RigidBody2D

var ship_name : String = "Basic Ship"
var ship_class : String = "independent"

# PHYSICS
var player_speed : float = 30000
# tons
var max_storage : int = 500
var storage : int = 0
var ship_weight : int = 1000
var weight : int = ship_weight + storage
var rotation_weight : float = 0.05
var max_fuel : int = 100
var fuel : float = max_fuel
var fuel_consumption : float = player_speed * weight / 3000000000
# in light years (from earth to sun to earth)
var max_speed : float = 0.00003

var max_health : int = 100
var health : float = max_health

var weapons : Array = []
var current_weapon : BasicWeapon
