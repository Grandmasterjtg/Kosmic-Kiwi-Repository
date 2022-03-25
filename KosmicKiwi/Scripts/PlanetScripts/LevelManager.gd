extends Node2D


func _ready() -> void:
	var ship = $Actors/Ship
	var nav_menu = $CanvasLayer/NavMenu
	print(ship)
	if ship and nav_menu:
		ship.connect("interacted", nav_menu, "toggle_nav_menu")
