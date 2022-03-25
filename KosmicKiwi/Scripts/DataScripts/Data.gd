extends Node

class_name Data

var m_data : Dictionary

func load_data(file_path : String) -> Dictionary:
	var json_data
	var file_data = File.new()

	file_data.open(file_path, File.READ)
	json_data = JSON.parse(file_data.get_as_text())
	file_data.close()

	return json_data.result
