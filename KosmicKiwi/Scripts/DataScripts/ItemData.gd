extends Node

var m_item_data : Dictionary

func _ready():
	m_item_data = load_data("res://Data/ItemData.json")
	
	print(m_item_data["Rope"])
	
func load_data(file_path : String) -> Dictionary:
	var json_data
	var file_data = File.new()
	
	file_data.open(file_path, File.READ)
	json_data = JSON.parse(file_data.get_as_text())
	file_data.close()
	
	return json_data.result

func get_item(index : String) -> Dictionary:
	return m_item_data[index]
