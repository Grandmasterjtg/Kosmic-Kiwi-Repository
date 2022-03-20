extends Node

const NUM_SLOTS := 20

var m_inventory := {} # {slot index: [item name, item quantity]}

# takes the name of an item and the amount of that item
# add that item and amount to the inventory or add the amount to the exisitng item
func add_item(item_name: String, item_quantity: int) -> void:
	var stack_size = ItemData.get_stack_size(item_name)
	
	var index = 0
	while(item_quantity > 0 and index < NUM_SLOTS):
		if m_inventory.has(index) == false:
			if item_quantity > stack_size:
				m_inventory[index] = [item_name, stack_size]
				item_quantity -= stack_size
			else:
				m_inventory[index] = [item_name, item_quantity]
				item_quantity -= item_quantity
		elif m_inventory[index][0] == item_name:
			if stack_size - m_inventory[index][1] < item_quantity:
				m_inventory[index][1] += (stack_size - m_inventory[index][1])
				item_quantity -= (stack_size - m_inventory[index][1])
			else:
				m_inventory[index][1] += item_quantity
				item_quantity -= item_quantity
		
		index += 1
		
# takes an item name
# removes 1 instance of that item form the inventory
func remove_item(item_name: String, amount: int = 1) -> bool:
	for slot in m_inventory:
		if m_inventory[slot][0] == item_name:
			if m_inventory[slot][1] >= amount:
				m_inventory[slot][1] -= amount
				if m_inventory[slot][1] <= 0:
					m_inventory.erase(slot)
				return true
		
	return false


# takes an index in the inventory
# returns true if the inventory has an item at that index
func item_exists_at_index(index: int) -> bool:
	return m_inventory.has(index)


# takes an index
# returns the name of the item at that index
func get_item_name(index: int) -> String:
	return m_inventory[index][0]
# takes an index
# returns the quantity of the item at that index
func get_item_quantity(index: int) -> int:
	return m_inventory[index][1]
	
func num_slots() -> int:
	return NUM_SLOTS
	
	
