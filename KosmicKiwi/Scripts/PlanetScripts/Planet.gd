extends Node

class_name Planet

var m_planet_name := "Planet"
var m_required_items = []
var m_can_travel_to := false

func _init(planet_name : String):
	self.m_planet_name = planet_name

func add_required_item(item_name : String):
	m_required_items.append(item_name)

