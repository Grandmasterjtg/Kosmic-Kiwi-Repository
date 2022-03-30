extends Node2D

onready var interactable = $Interactable

# interaction variables
const INTERACT := "interact"
const NAV_MENU := "/root/Node2D/CanvasLayer/NavMenu"

var m_in_area := false
var m_current_ship_parts = []

signal interacted

func _ready() -> void:
	# resource setup
	interactable.connect("interacted", self, "_on_interact")
	interactable.connect("entered", $ButtonDisplay, "toggle_display")
	interactable.connect("exited", $ButtonDisplay, "toggle_display")
	
	# progression setup
	# connect("ship_part_added",ProgressionManager,"on_ship_part_added")

func _on_interact() -> void:
	emit_signal("interacted")
