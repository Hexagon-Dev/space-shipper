class_name BasicShip extends CharacterBody2D

var ship_name = "Basic Ship"
var ship_class = "independent"

# PHYSICS
var player_speed = 0.01
# tons
var max_storage = 500
var storage = 0
var ship_weight = 1000
var weight = ship_weight + storage
var rotation_weight = 0.05
var max_fuel = 100
var fuel = max_fuel
var fuel_consumption = player_speed * weight / 10000
# in light years (from earth to sun to earth)
var max_speed = 0.00003

# AMMO

var max_bullets = 40
var bullets = max_bullets
# per second
var bullets_fire_speed = 1
var bullet_speed = 400
var reload = 0

var max_health = 100
var health = max_health
