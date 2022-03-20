extends Control

const SLOT_CLASS := preload("res://Scripts/InventoryScripts/Slot.gd")
onready var resource_slots := $ResourceInventory
onready var ship_slots := $ShipInventory

func _ready():
	update_inventory()

func update_inventory():
	var slots = resource_slots.get_children()
	for i in range(slots.size()):
		if Inventory.item_exists_at_index(i):
			slots[i].initialize_item(Inventory.get_item_name(i), Inventory.get_item_quantity(i))
		else:
			slots[i].delete_item()
