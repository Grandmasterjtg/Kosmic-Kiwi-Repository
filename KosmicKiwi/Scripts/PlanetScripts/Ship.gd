extends Node2D

onready var interactable = $Interactable

var m_in_area := false
var m_current_ship_parts = []

signal interacted

func _ready() -> void:
	# resource setup
	interactable.connect("interacted", self, "_on_interact")
	interactable.connect("entered", $ButtonDisplay, "toggle_display")
	interactable.connect("exited", $ButtonDisplay, "toggle_display")
	
	# indicator setup
	interactable.connect("entered", $IndicatorBubble, "open_bubble")
	interactable.connect("exited", $IndicatorBubble, "close_bubble")

func _on_interact() -> void:
	emit_signal("interacted")
