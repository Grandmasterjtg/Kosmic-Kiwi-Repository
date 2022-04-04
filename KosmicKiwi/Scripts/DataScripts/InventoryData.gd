extends Data

const FILE_PATH := "res://Data/InventoryData.json"

const NUM_SLOTS = "NumSlots"
const INTERACTABLE = "Interactable"

func _ready():
	m_data = load_data(FILE_PATH)

# returns a copy of the data form the InventoryData.json file
# returns and empty Dictionary if m_data is null
func get_inventory_data():
	if m_data:
		return m_data.duplicate(true)
	else:
		return null
	
# takes a string category
# returns the int number of slots at that index
# returns 0 if the data doesn't exist
func get_num_slots(category: String) -> int:
	if m_data and m_data.has(category):
		return m_data[category][NUM_SLOTS]
	else:
		return 0

# takes a string category
# retursn the bool value of whether the slots of that category are interactable
func get_is_interactable(category: String) -> bool:
	if m_data and m_data.has(category):
		return m_data[category][INTERACTABLE]
	else:
		return false


