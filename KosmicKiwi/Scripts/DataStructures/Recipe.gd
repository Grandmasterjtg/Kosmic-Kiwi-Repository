extends Node

class_name Recipe

var m_item_name : String
var m_recipe : Array # [ [ItemName, RequiredAmount] ]
var m_quantity : int

func _init(recipe: Array, quantity: int):
	m_recipe = recipe
	m_quantity = quantity
	
func get_quantity() -> int:
	return m_quantity
	
func set_item_name(item_name: String) -> void:
	m_item_name = item_name
func get_item_name() -> String:
	return m_item_name

# takes an index and returns the name of the required item at that index
func get_required_item(index: int) -> String:
	return m_recipe[index][0]

# takes an index and returns the amount requried of the item at that index
func get_required_amount(index: int) -> int:
	return m_recipe[index][1]

# returns the number of required items in the recipe
func size() -> int:
	return len(m_recipe)
