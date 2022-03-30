extends Node

var m_current_ship_parts : Dictionary
var planets : Array = [
	Planet.new("Planet 0"),
	Planet.new("Planet 1"),
	Planet.new("Planet 2"),
	Planet.new("Planet 3")
]


func _ready():
	# planets.append(new Planet("Planet 1")
	pass

func add_ship_part(part_name : String):
	m_current_ship_parts[part_name] = true

func check_for_ship_part(part_name : String) -> bool:
	return m_current_ship_parts.has(part_name)

func update_planets():
	# check ship parts to see if you can travel to planets
	pass
