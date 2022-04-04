extends Node

var planets = [
	Planet.new("Planet 0", "res://Levels/Planet_0.tscn"),
	Planet.new("Planet 1", "res://Levels/Planet_1.tscn"),
	Planet.new("Planet 2", "res://Levels/Tests/FriendTest_scene.tscn"),
	Planet.new("Planet 3", "res://Levels/Tests/Test.tscn")
]

func _ready():
	planets[2].add_required_item("Fiber")
	planets[3].add_required_item("Liquid")
	planets[3].add_required_item("Metal")
	# update_planets()

func update_planets():
	for planet in planets:
		planet.check_required_items()
