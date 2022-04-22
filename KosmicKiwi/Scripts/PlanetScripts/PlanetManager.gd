extends Node

var m_planets = [ # setup each planet in this array, index is important
	Planet.new("Forest", "res://Levels/Level_1_Planet_1.tscn"),
	Planet.new("Jungle", "res://Levels/Old/Level_2_Planet_2.tscn"),
	Planet.new("Wet", "res://Levels/Level_1_Planet_1.tscn"),
	Planet.new("Desert", "res://Levels/Level_1_Planet_1.tscn")
]
var m_active_planet : Planet = m_planets[0]
var m_ship_visual_index := 0

var m_forest_visited

func _ready():
	# find the root node and set m_active_planet to it's planet_index
	print("PlanetManager loading: " + m_active_planet.get_planet_name())
	if (get_tree().get_nodes_in_group("level_root").size() > 0):
		var root = get_tree().get_nodes_in_group("level_root")[0]
		m_active_planet = get_planet_at_index(root.get_planet_index())
	else:
		printerr("PlanetManager: No node in 'level_root' group")
	
	# setup required items for planets
	m_planets[1].add_required_item("Engine")
	m_planets[2].add_required_item("Engine")
	m_planets[3].add_required_item("Engine")
	m_planets[3].add_required_item("Shield")
	m_planets[3].add_required_item("Solar Sail")
	
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
