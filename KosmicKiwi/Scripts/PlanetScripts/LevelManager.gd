extends Node2D

export var m_planet_index := 0

func _ready() -> void:
	# setup ship
	setup_ship()
	UIManager.close_all_menus()
	SoundManager.play_loop(PlanetManager.get_planet_at_index(m_planet_index).get_planet_name())
	play_arrival_dialog()

func setup_ship():
	var ship = $Actors/Ship
	var nav_menu = $UI_Layer/NavMenu
	if ship and nav_menu:
		ship.connect("interacted", nav_menu, "toggle_nav_menu")
	else:
		printerr("Failed to setup Ship and Nav_Menu in LevelManager!")

func play_arrival_dialog():
	DialogManager.play_planet_arrive_dialog(PlanetManager.get_active_planet().get_planet_name())

func get_planet_index() -> int:
	return m_planet_index
