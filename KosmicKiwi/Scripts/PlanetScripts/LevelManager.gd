extends Node2D

func _ready() -> void:
	$Ship.connect("interacted",$CanvasLayer/NavMenu,"toggle_nav_menu")

