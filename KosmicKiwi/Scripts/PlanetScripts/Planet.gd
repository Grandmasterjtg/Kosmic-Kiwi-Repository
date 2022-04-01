extends Node

class_name Planet

var m_planet_name := "planet name"
var m_planet_path := "planet path"
var m_required_items = []
var m_travelable := false

func _init(planet_name : String, planet_path : String):
	self.m_planet_name = planet_name
	self.m_planet_path = planet_path

func add_required_item(item_name : String):
	self.m_required_items.append(item_name)

func check_required_items() -> bool:
	var all_items_found := true
	for item in m_required_items:
		if (!Inventory.item_exists_in_inventory(item)):
			all_items_found = false
			break
	m_travelable = all_items_found
	return all_items_found

func get_planet_name() -> String:
	return self.m_planet_name

func get_planet_path() -> String:
	return self.m_planet_path

func get_required_items() -> Array:
	return self.m_required_items

func travelable() -> bool:
	return self.m_travelable

func set_planet_name(new_name : String):
	self.m_planet_name = new_name

func set_planet_path(new_path : String):
	self.m_planet_path = new_path

func set_travelable(state : bool):
	self.m_travelable = state
