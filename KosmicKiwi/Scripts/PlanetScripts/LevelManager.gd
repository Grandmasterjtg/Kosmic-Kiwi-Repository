extends Node2D

export var m_planet_index := 0

func _ready() -> void:
	# setup ship
	setup_ship()
	UIManager.close_all_menus()
	var dialog = Dialogic.start("testConvo")
	add_child(dialog)

func setup_ship():
	var ship = $Actors/Ship
	var nav_menu = $UI_Layer/NavMenu
	if ship and nav_menu:
		ship.connect("interacted", nav_menu, "toggle_nav_menu")
	else:
		printerr("Failed to setup Ship and Nav_Menu in LevelManager!")

func get_planet_index() -> int:
	return m_planet_index
