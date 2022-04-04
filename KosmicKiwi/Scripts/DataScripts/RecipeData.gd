extends Data

const FILE_PATH := "res://Data/RecipeData.json"
var m_item_names : Array

const RECIPE = "Recipe"
const QUANTITY = "Quantity"

func _ready() -> void:
	m_data = load_data(FILE_PATH)
	
	# convert the data in m_data into instances of the Recipe class
	if m_data:
		# for each to be crafted in the json file
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
	if json_dct and json_dct.has(RECIPE) and json_dct[QUANTITY]:
		return Recipe.new(json_dct[RECIPE], json_dct[QUANTITY])
	else:
		return null

# takes an item name
# returns all the recipes associated with that item
func get_item_recipes(item_name: String):
	if m_data and m_data.has(item_name):
		return m_data[item_name].duplicate()
	else:
		return null
	
func get_all_recipes():
	if m_data:
		return m_data.duplicate()
	else:
		return null
	
func get_all_items():
	if m_item_names.size() > 0:
		return m_item_names
	else:
		return null
