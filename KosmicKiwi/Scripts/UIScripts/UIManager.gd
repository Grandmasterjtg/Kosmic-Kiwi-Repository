extends Node

var m_num_menus := 0

func open_menu() -> void:
	m_num_menus += 1

func close_menu() -> void:
	if m_num_menus > 0:
		m_num_menus -= 1

func menus_closed() -> bool:
	if m_num_menus <= 0:
		return true
	else:
		return false
