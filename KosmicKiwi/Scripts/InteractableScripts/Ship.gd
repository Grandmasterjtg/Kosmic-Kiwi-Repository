extends Node2D

onready var interactable = $Interactable

# interaction variables
var m_in_area := false
const INTERACT := "interact"
const NAV_MENU := "/root/Node2D/CanvasLayer/NavMenu"

signal interacted

# UI variables
var m_nav_menu

func _ready() -> void:
	# resource setup
	interactable.connect("interacted", self, "_on_interact")
	interactable.connect("entered", $ButtonDisplay, "toggle_display")
	interactable.connect("exited", $ButtonDisplay, "toggle_display")
	
	# nav menu setup
	#m_nav_menu = get_node(NAV_MENU)
	#if (m_nav_menu == null):
	#	printerr("Nav_Menu was not found!")
	
func _on_interact() -> void:
	emit_signal("interacted")
	#if (m_nav_menu != null):
	#	m_nav_menu.visible = !m_nav_menu.visible
