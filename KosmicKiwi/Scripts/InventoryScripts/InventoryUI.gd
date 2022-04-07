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

# refresh the inventory slots with the correct items
func update_inventory():
	var categories = InventoryData.get_inventory_data()
	
	# check if categories is null
	if categories:
		for category in categories:
			# get the inventory from the Inventory script
			var inventory = Inventory.get_inventory(category)
			
			# null checks
			
			if inventory != null and m_inventory_slots.has(category):
				var slots = m_inventory_slots[category].get_children()
				# print(slots.size())
				# print("InventoryUI update_inventory: " + category + str(slots.size()))
				
				var index = 0
				# add the items in the inventory to the UI
				for item in inventory:
					var item_name = item
					var item_quantity = Inventory.get_item_quantity(item)
					slots[index].initialize_item(item_name, item_quantity)
					index += 1
				
				# remove any leftover items form the UI
				for i in range(index, slots.size()):
					slots[i].delete_item()

func test(var1, var2) -> bool:
	if var1 and m_inventory_slots.has(var2):
		return true
	else:
		return false

#func update_inventory():
#	var categories = InventoryData.get_inventory_data()
#
#	if categories:
#		for _category in categories:
#			var slots = m_inventory_slots[_category].get_children()
#			for i in range(slots.size()):
#				if Inventory.item_exists_at_index(i, _category):
#					var item_name = Inventory.get_item_name(i, _category)
#					var item_quantity = Inventory.get_item_quantity(i, _category)
#					slots[i].initialize_item(item_name, item_quantity)
#				else:
#					slots[i].delete_item()
