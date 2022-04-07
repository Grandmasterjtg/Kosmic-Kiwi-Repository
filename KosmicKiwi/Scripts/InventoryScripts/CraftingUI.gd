extends Control

const RECIPE_UI_CLASS = preload("res://Scenes/UI/Inventory/RecipeUI.tscn")
onready var m_recipe_display = $ScrollContainer/RecipeDisplay

func _ready():
	var items = RecipeData.get_all_items()

	# initiate RecipeUI scene for each recipe that exists
	var index = 0
	for item in items:
		var recipes = RecipeData.get_item_recipes(item)
		for recipe in recipes:
			var recipe_ui = RECIPE_UI_CLASS.instance()
			m_recipe_display.add_child(recipe_ui)
			recipe_ui.initialize_recipe(recipe)
			index += 1
