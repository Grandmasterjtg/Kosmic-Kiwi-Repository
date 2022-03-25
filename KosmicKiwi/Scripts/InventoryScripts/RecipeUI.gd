extends Panel

const SLOT_CLASS = preload("res://Scenes/UI/Inventory/Slot.tscn")

onready var m_item_to_craft = $ItemToCraft
onready var m_recipe_display = $Recipes

func initialize_recipe(recipe: Recipe):
	m_item_to_craft.initialize_item(recipe.get_item_name(), recipe.get_quantity())
