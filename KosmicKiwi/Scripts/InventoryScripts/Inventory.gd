extends Node

var m_num_slots := {} # { ItemCategory: NumSlots }
const HOTBAR_SLOTS := 4

var m_inventory := {} # { ItemCategory: { SlotIndex: [ItemName, ItemQuantity] } }
var m_hotbar := {} # { [Category, InventorySlotIndex]: [ItemName, ItemQuantity, IsSelected] }

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
func add_item(item_name: String, item_quantity: int) -> void:
	var category = ItemData.get_category(item_name)
	
	# if the inventory has data for the category
	if category and m_inventory.has(category) and m_num_slots.has(category):
		var inventory = m_inventory[category]
		var num_slots = m_num_slots[category]
		
		var stack_size = ItemData.get_stack_size(item_name)
		
		# if the item already exists in the inventory add to it
		if item_exists_in_inventory(item_name):
			var item_added = false
			var index = 0
			while !item_added and index < num_slots:
				# find the item stack in the inventory
				if inventory.has(index) and inventory[index][0] == item_name:
					# if remaining space is greater than the amount to add
					if stack_size - inventory[index][1] >= item_quantity:
						inventory[index][1] += item_quantity
					else:
						inventory[index][1] = stack_size
					item_added = true
				index += 1
		# if the item doesn't exist in the inventory add to first empty slot
		else:
			var item_added = false
			var index = 0
			while !item_added and index < num_slots:
				# if slot is emtpy
				if !inventory.has(index):
					# if the amount to add is less than the max stack size
					if stack_size >= item_quantity:
						inventory[index] = [item_name, item_quantity]
					else:
						inventory[index] = [item_name, stack_size]
					item_added = true
				index += 1
		
		emit_signal("inventory_updated")
		
# takes an item name
# removes 1 instance of that item form the inventory
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
					remove_from_hotbar(category, slot)
					# m_hotbar.erase([category,slot])
				emit_signal("inventory_updated")
				return true
		
	return false


# takes the category of inventory and the slot index of the item
# adds the array value [ItemName, ItemQuantity] to the hotbar in the first empty slot
# returns true if item was added to the hotbar
func add_to_hotbar(category: String, slot: int) -> bool:
	if !m_hotbar.has([category, slot]) and m_hotbar.size() < HOTBAR_SLOTS:
		m_hotbar[[category, slot]] = m_inventory[category][slot]
		emit_signal("inventory_updated")
		return true
	else:
		return false

func remove_from_hotbar(category: String, slot: int) -> bool:
	if m_hotbar.has([category, slot]):
		m_hotbar.erase([category, slot])
		emit_signal("inventory_updated")
		return true
	else:
		return false


# takes the array value of the item [ItemName, ItemQuantity] in the inventory
# checks if the array matches any of the values in the hotbar
# returns true if it already exists in the hotbar
func item_exists_in_hotbar(category: String, slot: int) -> bool:
	if m_hotbar.has([category, slot]):
		return true
	else:
		return false
		

# takes an index in the inventory
# returns true if the inventory has an item at that index
func item_exists_at_index(index: int, category: String) -> bool:
	return m_inventory[category].has(index)

# takes an item name and an item amount
# if there exists an amount of that item in the inventory, return true
func item_exists_in_inventory(item_name: String, amount: int=1) -> bool:
	var category = ItemData.get_category(item_name)
	
	if category and m_inventory.has(category):
		var inventory = m_inventory[category]
		
		for slot in inventory:
			if inventory[slot][0] == item_name and inventory[slot][1] >= amount:
				return true
	
	return false


# takes an index
# returns the name of the item at that index
func get_item_name(index: int, category: String):
	if m_inventory and m_inventory.has(category):
		return m_inventory[category][index][0]
	else:
		return null
	
# takes an index
# returns the quantity of the item at that index
func get_item_quantity(index: int, category: String) -> int:
	if m_inventory and m_inventory.has(category):
		return m_inventory[category][index][1]
	else:
		return 0

# return the values in the hotbar dictionary
func get_items_in_hotbar() -> Array:
	return m_hotbar.values()
# return the key values from the hotbar dictionary
# the key values represent the slots from the inventory that an item is comeing from
func get_slots_in_hotbar() -> Array:
	return m_hotbar.keys()
