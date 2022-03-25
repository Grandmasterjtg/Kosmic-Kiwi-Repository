extends Node2D

func _ready() -> void:
	$Actors/Ship.connect("interacted",$CanvasLayer/NavMenu,"toggle_nav_menu")

