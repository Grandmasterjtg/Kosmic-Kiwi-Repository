extends Node

class_name FriendAbility

var m_ability_name = "defaultName"
var m_ability_radius = 1.0

func get_name():
	return m_ability_name
	
func set_name(new_name):
	m_ability_name = new_name

func use_ability():
	print(m_ability_name + " has no functionality yet.")
	set_name("UsedAbility")


