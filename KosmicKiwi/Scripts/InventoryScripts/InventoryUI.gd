extends Control

const SLOT_CLASS := preload("res://Scripts/InventoryScripts/Slot.gd")

onready var m_sections = $Sections
onready var m_inventory_slots = {}

onready var m_resource_slots := $Sections/ResourceInventory
onready var m_ship_slots := $Sections/ShipInventory
onready var m_tool_slots := $Sections/ToolInventory

func _ready():
	var sections = m_sections.get_children()
	var index = 1
	for _section in sections:
		m_inventory_slots[_section.get_category()] = _section
		
	Inventory.connect("inventory_updated", self, "update_inventory")
	
	update_inventory()

func update_inventory():
	var categories = ItemCategories.get_categories()
	for _category in categories:
		var slots = m_inventory_slots[_category[0]].get_children()
		for i in range(slots.size()):
			if Inventory.item_exists_at_index(i, _category[0]):
				var item_name = Inventory.get_item_name(i, _category[0])
				var item_quantity = Inventory.get_item_quantity(i, _category[0])
				slots[i].initialize_item(item_name, item_quantity)
			else:
				slots[i].delete_item()
