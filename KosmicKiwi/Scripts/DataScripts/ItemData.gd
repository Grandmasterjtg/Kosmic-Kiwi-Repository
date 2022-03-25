extends Data

const FILE_PATH = "res://Data/ItemData.json"

func _ready():
	m_data = load_data(FILE_PATH)

func get_item(item_name : String) -> Dictionary:
	return m_data[item_name]
	
func get_stack_size(item_name: String) -> int:
	return m_data[item_name]["StackSize"]
	
func get_category(item_name: String) -> String:
	return m_data[item_name]["ItemCategory"]
