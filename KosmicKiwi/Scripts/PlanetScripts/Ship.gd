extends Node2D

onready var interactable = $Interactable

var m_in_area := false
var m_current_ship_visual_index := 0

signal interacted

func _ready() -> void:
	# resource setup
	interactable.connect("interacted", self, "_on_interact")
	interactable.connect("entered", $ButtonDisplay, "toggle_display")
	interactable.connect("exited", $ButtonDisplay, "toggle_display")
	
	# indicator setup
	interactable.connect("entered", $IndicatorBubble, "open_bubble")
	interactable.connect("exited", $IndicatorBubble, "close_bubble")
	
	# setup shit (for between scenes)
	check_ship_parts()

func _on_interact() -> void:
	emit_signal("interacted")
	check_ship_parts()

func check_ship_parts():
	if (Inventory.item_exists_in_inventory("Engine")):
		m_current_ship_visual_index = 1
		if (Inventory.item_exists_in_inventory("Solar Sail")):
			m_current_ship_visual_index = 2
			if (Inventory.item_exists_in_inventory("Shield")):
				m_current_ship_visual_index = 3
				if (Inventory.item_exists_in_inventory("Shield") and Inventory.item_exists_in_inventory("Solar Sail")):
					m_current_ship_visual_index = 4
	update_ship_visual(m_current_ship_visual_index)

func update_ship_visual(index: int):
	match m_current_ship_visual_index:
		0:
			$AnimatedSprite.animation = "ship_0"
		1:
			$AnimatedSprite.animation = "ship_1"
		2:
			$AnimatedSprite.animation = "ship_2"
		3:
			$AnimatedSprite.animation = "ship_3"
		4:
			$AnimatedSprite.animation = "ship_4"
	$AnimatedSprite.play()
