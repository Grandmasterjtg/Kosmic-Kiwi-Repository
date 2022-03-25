extends Data

const FILE_PATH := "res://Data/ResourceCollection.json"

func _ready():
	m_data = load_data(FILE_PATH)

func get_resource_data(resource_name: String) -> Dictionary:
	return m_data[resource_name]
