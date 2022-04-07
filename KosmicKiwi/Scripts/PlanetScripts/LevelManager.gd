extends Node2D

export var m_ship_node_path := ""
export var m_nav_menu_path := ""
export var m_planet_index := 0

func _ready() -> void:
	# setup ship
	setup_ship()

func setup_ship():
	var ship = get_node(m_ship_node_path)
	var nav_menu = get_node(m_nav_menu_path)
	if ship and nav_menu:
		ship.connect("interacted", nav_menu, "toggle_nav_menu")
	else:
		printerr("Failed to setup Ship and Nav_Menu in LevelManager!")

func get_planet_index() -> int:
	return m_planet_index
