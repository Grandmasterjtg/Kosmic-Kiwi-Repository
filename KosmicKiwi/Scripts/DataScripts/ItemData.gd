extends Node

var m_item_data : Dictionary

func _ready():
	m_item_data = load_data("res://Data/ItemData.json")
	
func load_data(file_path : String) -> Dictionary:
	var json_data
	var file_data = File.new()
	
	file_data.open(file_path, File.READ)
	json_data = JSON.parse(file_data.get_as_text())
	file_data.close()
	
	return json_data.result

func get_item(item_name : String) -> Dictionary:
	return m_item_data[item_name]
	
func get_stack_size(item_name: String) -> int:
	return m_item_data[item_name]["StackSize"]
