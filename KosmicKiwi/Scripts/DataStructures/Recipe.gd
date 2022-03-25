extends Node

class_name Recipe

var m_item_name : String
var m_recipe : Array
var m_quantity : int

func _init(recipe: Array, quantity: int):
	m_recipe = recipe
	m_quantity = quantity
	
func get_recipe() -> Array:
	return m_recipe.duplicate()
	
func get_quantity() -> int:
	return m_quantity
	
func set_item_name(item_name: String) -> void:
	m_item_name = item_name
func get_item_name() -> String:
	return m_item_name
