extends Node

var m_current_ship_parts : Dictionary

func _ready():
	pass

func add_ship_part(part_name : String):
	m_current_ship_parts[part_name] = true

func check_for_ship_part(part_name : String) -> bool:
	return m_current_ship_parts.has(part_name)
