extends Data

const FILE_PATH = "res://Data/ItemData.json"

const STACK = "StackSize"
const CATEGORY = "ItemCategory"
const PLACEABLE = "Placeable"
const TOOL_TIP = "ToolTip"

func _ready():
	m_data = load_data(FILE_PATH)

func get_item(item_name : String):
	if m_data and m_data.has(item_name):
		return m_data[item_name]
	else:
		return null
	
# takes an item name
# returns the stack size of that item or 0 if it doesn't exist
func get_stack_size(item_name: String) -> int:
	if m_data and m_data.has(item_name) and m_data[item_name].has(STACK):
		return m_data[item_name][STACK]
	else:
		return 0

# takes an item name
# returns the category of that item or null if it doesn't exist
func get_category(item_name: String):
	if m_data and m_data.has(item_name) and m_data[item_name].has(CATEGORY):
		return m_data[item_name][CATEGORY]
	else:
		return null

# takes an item name
# returns whether or not that item is placeable or null if it doesn't exist
func is_placeable(item_name: String):
	if m_data and m_data.has(item_name) and m_data[item_name].has(PLACEABLE):
		return m_data[item_name][PLACEABLE]
	else:
		return null

# takes an item name
# return the tool tip associated with that item or null if it doesn't exist
func get_tool_tip(item_name: String):
	if m_data and m_data.has(item_name) and m_data[item_name].has(TOOL_TIP):
		return m_data[item_name][TOOL_TIP]
	else:
		return null
