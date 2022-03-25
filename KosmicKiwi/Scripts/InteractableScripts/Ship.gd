extends Node2D

onready var interactable = $Interactable

# interaction variables
var m_in_area := false
const INTERACT := "interact"

func _ready() -> void:
	# resource setup
	interactable.connect("interacted", self, "_on_interact")
	interactable.connect("entered", $ButtonDisplay, "toggle_display")
	interactable.connect("exited", $ButtonDisplay, "toggle_display")
	
func _on_interact() -> void:
	print("Ship interacted with!")
