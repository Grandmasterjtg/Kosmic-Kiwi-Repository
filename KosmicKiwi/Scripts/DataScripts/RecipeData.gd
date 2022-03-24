extends Data

const FILE_PATH := "res://Data/RecipeData.json"
var m_recipe_data : Dictionary

func _ready() -> void:
	m_data = load_data(FILE_PATH)
