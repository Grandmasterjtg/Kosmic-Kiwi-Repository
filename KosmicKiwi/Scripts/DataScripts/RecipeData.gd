extends Data

const FILE_PATH := "res://Data/RecipeData.json"
var m_item_names : Array

func _ready() -> void:
	m_data = load_data(FILE_PATH)
	
	# for each to be crafted int eh json file
	for item in m_data:
		# add the item to craft to the item names array
		m_item_names.append(item)
		# for each recipe for the item to be crafted
		for i in range(m_data[item].size()):
			# create a Recipe object using the data from the recipe
			m_data[item][i] = json_to_recipe(m_data[item][i])
			# set the Recipe's name to the item to be crated's name
			m_data[item][i].set_item_name(item)
			

# converts a json dictionary to a Recipe object
# returns the Recipe ojbect created	
func json_to_recipe(json_dct: Dictionary) -> Recipe:
	return Recipe.new(json_dct["Recipe"], json_dct["Quantity"])
	
func get_item_recipes(index: String) -> Array:
	return m_data[index]
	
func get_all_recipes() -> Dictionary:
	return m_data.duplicate()
	
func get_all_items() -> Array:
	return m_item_names
