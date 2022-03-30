extends Control

onready var m_sections = $Sections
onready var m_inventory_slots = {}

func _ready():
	var sections = m_sections.get_children()
	var index = 1
	for _section in sections:
		m_inventory_slots[_section.get_category()] = _section
		
	Inventory.connect("inventory_updated", self, "update_inventory")
	
	update_inventory()

func update_inventory():
	var categories = InventoryData.get_inventory_data()
	for _category in categories:
		var slots = m_inventory_slots[_category].get_children()
		for i in range(slots.size()):
			if Inventory.item_exists_at_index(i, _category):
				var item_name = Inventory.get_item_name(i, _category)
				var item_quantity = Inventory.get_item_quantity(i, _category)
				slots[i].initialize_item(item_name, item_quantity)
			else:
				slots[i].delete_item()
