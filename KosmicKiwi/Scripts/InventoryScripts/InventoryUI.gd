extends Control

const SLOT_CLASS := preload("res://Scripts/InventoryScripts/Slot.gd")
onready var m_resource_slots := $ResourceInventory
onready var m_ship_slots := $ShipInventory
onready var m_tool_slots := $ToolInventory

func _ready():
	update_inventory()

func update_inventory():
	# resource inventory display
	var slots = m_resource_slots.get_children()
	var category = ItemCategories.category(0)
	for i in range(slots.size()):
		if Inventory.item_exists_at_index(i, category):
			slots[i].initialize_item(Inventory.get_item_name(i, category), Inventory.get_item_quantity(i, category))
		else:
			slots[i].delete_item()
			
	# tool inventory display
	slots = m_tool_slots.get_children()
	category = ItemCategories.category(1)
	for i in range(slots.size()):
		if Inventory.item_exists_at_index(i, category):
			slots[i].initialize_item(Inventory.get_item_name(i, category), Inventory.get_item_quantity(i, category))
		else:
			slots[i].delete_item()
			
	# ship inventory display
	slots = m_ship_slots.get_children()
	category = ItemCategories.category(2)
	for i in range(slots.size()):
		if Inventory.item_exists_at_index(i, category):
			slots[i].initialize_item(Inventory.get_item_name(i, category), Inventory.get_item_quantity(i, category))
		else:
			slots[i].delete_item()
