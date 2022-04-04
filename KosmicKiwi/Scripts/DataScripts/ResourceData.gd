extends Data

const FILE_PATH := "res://Data/ResourceCollection.json"

const ITEM = "ItemName"
const QUANTITY = "Quantity"
const COOLDOWN = "Cooldown"
const TOOL = "RequiredTool"

func _ready():
	m_data = load_data(FILE_PATH)

func get_resource_data(resource_name: String):
	if m_data and m_data.has(resource_name):
		return m_data[resource_name]
	else:
		return null
	
func get_item_name(resource_name: String):
	if m_data and m_data.has(resource_name) and m_data[resource_name].has(ITEM):
		return m_data[resource_name][ITEM]
	else:
		return null
		
func get_quantity(resource_name: String):
	if m_data and m_data.has(resource_name) and m_data[resource_name].has(QUANTITY):
		return m_data[resource_name][QUANTITY]
	else:
		return null
		
func get_cooldown(resource_name: String):
	if m_data and m_data.has(resource_name) and m_data[resource_name].has(COOLDOWN):
		return m_data[resource_name][COOLDOWN]
	else:
		return null
		
func get_tool(resource_name: String):
	if m_data and m_data.has(resource_name) and m_data[resource_name].has(TOOL):
		return m_data[resource_name][TOOL]
	else:
		return null
	
