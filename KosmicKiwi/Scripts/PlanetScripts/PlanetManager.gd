extends Node

var m_planets = [ # setup each planet in this array, index is important
	Planet.new("Planet 0", "res://Levels/Planet_0.tscn"),
	Planet.new("Planet 1", "res://Levels/Planet_1.tscn"),
	Planet.new("Planet 1", "res://Levels/Level_1_Planet_1.tscn"),
	Planet.new("Planet 2", "res://Levels/Tests/FriendTest_scene.tscn"),
	Planet.new("Planet 3", "res://Levels/Tests/Test.tscn")
]
var m_active_planet : Planet = m_planets[0]
var m_ship_visual_index := 0

func _ready():
	# find the root node and set m_active_planet to it's planet_index
	print("PlanetManager loading: " + m_active_planet.get_planet_name())
	if (get_tree().get_nodes_in_group("level_root").size() > 0):
		var root = get_tree().get_nodes_in_group("level_root")[0]
		m_active_planet = get_planet_at_index(root.get_planet_index())
	else:
		printerr("PlanetManager: No node in 'level_root' group")
	
	# setup required items for planets
	m_planets[1].add_required_item("Fiber")
	m_planets[3].add_required_item("Liquid")
	m_planets[3].add_required_item("Metal")
	
	# update planets and ship
	update_planets()

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
