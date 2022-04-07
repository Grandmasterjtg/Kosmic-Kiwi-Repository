extends Node

var m_num_slots := {} # { ItemCategory: NumSlots }
const HOTBAR_SLOTS := 4

var m_inventory := {} # { ItemCategory: { ItemName: [ItemName, ItemQuantity] } }
var m_hotbar := {} # { ItemName: [ItemName, ItemQuantity] }

var m_selected_item = null

signal inventory_updated


func _ready() -> void:
	# set up the inventory with each categor form InventoryData
	var categories = InventoryData.get_inventory_data()
	if categories:
		for category in categories:
			m_inventory[category] = {}
			m_num_slots[category] = InventoryData.get_num_slots(category)


# takes the name of an item and the amount of that item
# add that item and amount to the inventory or add the amount to the exisitng item
func add_item(item_name: String, item_quantity: int) -> bool:
	var category = ItemData.get_category(item_name)
	
	# if the inventory has data for the category
	if category and m_inventory.has(category) and m_num_slots.has(category):
		var inventory = m_inventory[category]
		var num_slots = m_num_slots[category]
		
		var stack_size = ItemData.get_stack_size(item_name)
		
		# if the item already exists in the inventory add to it
		if item_exists_in_inventory(item_name):
			if stack_size - inventory[item_name][1] >= item_quantity:
				inventory[item_name][1] += item_quantity
			else:
				inventory[item_name][1] = stack_size
		# if the item doesn't exist, add it to a new slot
		else:
			if stack_size >= item_quantity:
				inventory[item_name] = [item_name, item_quantity]
			else:
				inventory[item_name] = [item_name, stack_size]
		
		emit_signal("inventory_updated")
		return true
	else:
		return false
		
# takes an item name and an amount to remove
# if enough of the item exists, it is removed from the inventory
# returns true if the item was removed
func remove_item(item_name: String, amount: int = 1) -> bool:
	var category = ItemData.get_category(item_name)
	
	if category and m_inventory.has(category):
		var inventory = m_inventory[category]
		
		for slot in m_inventory[category]:
			# if the item name at the slot matches to passed item name and there is enought of the item
			if inventory[slot][0] == item_name and inventory[slot][1] >= amount:
				inventory[slot][1] -= amount
				# if there is no more of the item left in the inventory
				if inventory[slot][1] <= 0:
					# erase the value in the inventory
					inventory.erase(slot)
					# if item exists in the hotbar, erase it
					remove_from_hotbar(item_name)
				print("Inventory remove_item: " + item_name)
				emit_signal("inventory_updated")
				return true
		
	return false
	

# takes and item name
# if the item exists in the hotbar, that item is set as the selected item
# if the item doens't exist or is null, the item is set to null
func set_selected_item(item_name) -> void:
	if item_name and item_exists_in_hotbar(item_name):
		m_selected_item = m_hotbar[item_name]
	else:
		m_selected_item = null

func get_selected_item():
	return m_selected_item
	
func check_selected_item(item_name) -> bool:
	if m_selected_item and item_name == m_selected_item[0]:
		return true
	else:
		return false


# takes the name of an item
# if the item exists in the inventory, the item form the inventory is added to the hotbar
# returns true if item was added to the hotbar
func add_to_hotbar(item_name: String) -> bool:
	var category = ItemData.get_category(item_name)
	
	if item_exists_in_inventory(item_name) and !m_hotbar.has(item_name) and m_hotbar.size() < HOTBAR_SLOTS:
		m_hotbar[item_name] = m_inventory[category][item_name]
		emit_signal("inventory_updated")
		return true
	else:
		return false


# takes the name of an item
# removes the item from the hotbar if it exists
# returns true if the item was removed
func remove_from_hotbar(item_name: String) -> bool:
	if m_hotbar.has(item_name):
		m_hotbar.erase(item_name)
		emit_signal("inventory_updated")
		return true
	else:
		return false


# takes the array value of the item [ItemName, ItemQuantity] in the inventory
# checks if the array matches any of the values in the hotbar
# returns true if it already exists in the hotbar
func item_exists_in_hotbar(item_name: String) -> bool:
	if m_hotbar.has(item_name):
		return true
	else:
		return false
		

# takes an index in the inventory
# returns true if the inventory has an item at that index
func _item_exists_at_index(index: int, category: String) -> bool:
	return m_inventory[category].has(index)

# takes an item name and an item amount
# if there exists an amount of that item in the inventory, return true
func item_exists_in_inventory(item_name: String, amount: int=1) -> bool:
	var category = ItemData.get_category(item_name)
	
	if (category and m_inventory.has(category) and m_inventory[category].has(item_name) 
			and m_inventory[category][item_name][1] >= amount):
		return true
	else:
		return false


# takes an index
# returns the name of the item at that index
func _get_item_name(index: int, category: String):
	if m_inventory and m_inventory.has(category):
		return m_inventory[category][index][0]
	else:
		return null
	
# takes an index
# returns the quantity of the item at that index
func get_item_quantity(item_name: String) -> int:
	var category = ItemData.get_category(item_name)
	
	if category and m_inventory.has(category) and m_inventory[category].has(item_name):
		return m_inventory[category][item_name][1]
	else:
		return 0

func get_inventory(category: String):
	if m_inventory.has(category):
		return m_inventory[category].duplicate(true)
	else:
		return null

# return the values in the hotbar dictionary
func get_items_in_hotbar() -> Array:
	return m_hotbar.values()
# return the key values from the hotbar dictionary
# the key values represent the slots from the inventory that an item is comeing from
func _get_sslots_in_hotbar() -> Array:
	return m_hotbar.keys()
