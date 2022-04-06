extends Node

var m_planets = [
	Planet.new("Planet 0", "res://Levels/Planet_0.tscn"),
	Planet.new("Planet 1", "res://Levels/Planet_1.tscn"),
	Planet.new("Planet 2", "res://Levels/Tests/FriendTest_scene.tscn"),
	Planet.new("Planet 3", "res://Levels/Tests/Test.tscn")
]
var m_active_planet : Planet = m_planets[1]

func _ready():
	m_planets[2].add_required_item("Fiber")
	m_planets[3].add_required_item("Liquid")
	m_planets[3].add_required_item("Metal")

func update_planets():
	for planet in m_planets:
		planet.check_required_items()
		
func get_planets() -> Array:
	return m_planets.duplicate()

func get_active_planet() -> Planet:
	return m_active_planet

func get_planet_at_index(index : int) -> Planet:
	return m_planets[index]

func set_active_planet(planet : Planet) -> void:
	m_active_planet = planet
