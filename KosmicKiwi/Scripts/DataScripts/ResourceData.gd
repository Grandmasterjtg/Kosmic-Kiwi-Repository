extends Node

var m_resource_data : Dictionary

func _ready():
	m_resource_data = load_data("res://Data/ResourceCollection.json")
	
func load_data(file_path: String) -> Dictionary:
	var json_data
	var file_data = File.new()
	
	file_data.open(file_path, File.READ)
	json_data = JSON.parse(file_data.get_as_text())
	file_data.close()
	
	return json_data.result

func get_resource_data(resource_name: String) -> Dictionary:
	return m_resource_data[resource_name]
