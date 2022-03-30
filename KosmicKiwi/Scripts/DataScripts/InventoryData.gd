extends Data

const FILE_PATH := "res://Data/InventoryData.json"

func _ready():
	m_data = load_data(FILE_PATH)

# returns a copy of the data form the InventoryData.json file
func get_inventory_data() -> Dictionary:
	return m_data.duplicate(true)
	
# takes a string category
# returns the int number of slots at that index
func get_num_slots(category: String) -> int:
	if m_data.has(category):
		return m_data[category]["NumSlots"]
	else:
		return 0

# takes a string category
# retursn the bool value of whether the slots of that category are interactable
func get_is_interactable(category: String) -> bool:
	if m_data.has(category):
		return m_data[category]["Interactable"]
	else:
		return false


