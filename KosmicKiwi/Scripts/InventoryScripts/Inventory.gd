extends Node

var m_num_slots := {} # { ItemCategory: NumSlots }
const HOTBAR_SLOTS := 4

var m_inventory := {} # { ItemCategory: { SlotIndex: [ItemName, ItemQuantity] } }
var m_hotbar := {} # { [Category, InventorySlotIndex]: [ItemName, ItemQuantity] }

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
	for slot in m_inventory[category]:
		# if the item name at the slot matches to passed item name and there is enought of the item
		if m_inventory[category][slot][0] == item_name and m_inventory[category][slot][1] >= amount:
			m_inventory[category][slot][1] -= amount
			# if there is no more of the item left in the inventory
			if m_inventory[category][slot][1] <= 0:
				# erase the value in the inventory
				m_inventory[category].erase(slot)
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
			
	return false

func remove_from_hotbar(category: String, slot: int) -> void:
	m_hotbar.erase([category, slot])
	emit_signal("inventory_updated")


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


# takes an index
# returns the name of the item at that index
func get_item_name(index: int, category: String) -> String:
	return m_inventory[category][index][0]
	
# takes an index
# returns the quantity of the item at that index
func get_item_quantity(index: int, category: String) -> int:
	return m_inventory[category][index][1]

# return the values in the hotbar dictionary
func get_items_in_hotbar() -> Array:
	return m_hotbar.values()
# return the key values form the hotbar dictionary
# the key values represent the slots form the inventory the item is coming from
func get_slots_in_hotbar() -> Array:
	return m_hotbar.keys()

func get_hotbar_item_name(index: int) -> String:
	return m_hotbar[index][0]
	
func get_hotbar_item_quantity(index: int) -> int:
	return m_hotbar[index][1]
