extends Node

var m_num_slots := {} # { ItemCategory: NumSlots }
const HOTBAR_SLOTS := 4

var m_inventory := {} # { ItemCategory: { SlotIndex: [ItemName, ItemQuantity] } }
var m_hotbar := {} # { SlotIndex: [ItemName, ItemQuantity] }

signal inventory_updated


func _ready() -> void:
	var categories = ItemCategories.get_categories()
	for _category in categories:
		m_inventory[_category[0]] = {}
		m_num_slots[_category[0]] = _category[1]
		
# takes the name of an item and the amount of that item
# add that item and amount to the inventory or add the amount to the exisitng item
func add_item(item_name: String, item_quantity: int) -> void:
	var category = ItemData.get_category(item_name)
	var inventory = m_inventory[category]
	var num_slots = m_num_slots[category]
	
	var stack_size = ItemData.get_stack_size(item_name)
	var index = 0
	while(item_quantity > 0 and index < num_slots):
		# if empty slot
		if inventory.has(index) == false:
			if item_quantity > stack_size:
				inventory[index] = [item_name, stack_size]
				item_quantity -= stack_size
			else:
				inventory[index] = [item_name, item_quantity]
				item_quantity -= item_quantity
		# if slot is not empty and is the same as the item to add
		elif inventory[index][0] == item_name:
			if stack_size - inventory[index][1] < item_quantity:
				inventory[index][1] += (stack_size - inventory[index][1])
				item_quantity -= (stack_size - inventory[index][1])
			else:
				inventory[index][1] += item_quantity
				item_quantity -= item_quantity

		index += 1
	
	emit_signal("inventory_updated")
		
# takes an item name
# removes 1 instance of that item form the inventory
func remove_item(item_name: String, amount: int = 1) -> bool:
	var category = ItemData.get_category(item_name)
	for slot in m_inventory:
		if m_inventory[category][slot][0] == item_name:
			if m_inventory[category][slot][1] >= amount:
				m_inventory[category][slot][1] -= amount
				if m_inventory[category][slot][1] <= 0:
					m_inventory.erase(slot)
				emit_signal("inventory_updated")
				return true
		
	return false


# takes an index in the inventory
# returns true if the inventory has an item at that index
func item_exists_at_index(index: int, category: String) -> bool:
	return m_inventory[category].has(index)


# takes an index
# returns the name of the item at that index
func get_item_name(index: int, category: String) -> String:
	return m_inventory[category][index][0]
# takes an index
# returns the quantity of the item at that index
func get_item_quantity(index: int, category: String) -> int:
	return m_inventory[category][index][1]
