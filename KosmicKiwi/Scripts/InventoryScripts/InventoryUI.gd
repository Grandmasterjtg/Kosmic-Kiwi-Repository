extends Control

const SLOT_CLASS := preload("res://Scripts/InventoryScripts/Slot.gd")
onready var resource_slots := $ResourceInventory

func _ready():
	update_inventory()

func update_inventory():
	var slots = resource_slots.get_children()
	for i in range(slots.size()):
		if Inventory.item_exists(i):
			slots[i].initialize_item(Inventory.get_item_name(i), Inventory.get_item_quantity(i))
