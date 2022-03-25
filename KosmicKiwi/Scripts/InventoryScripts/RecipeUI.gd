extends Panel

const SLOT_CLASS = preload("res://Scenes/UI/Inventory/Slot.tscn")

# display variables
onready var m_item_to_craft = $ItemToCraft
onready var m_recipe_display = $Recipes

# data variables
var m_recipe : Recipe

func _ready():
	$Craft.connect("button_down", self, "craft")

# takes a recipe variable
# initializes the display with the correct items and amounts
func initialize_recipe(recipe: Recipe):
	# initialize the recipe variable
	m_recipe = recipe
	
	m_item_to_craft.initialize_item(recipe.get_item_name(), recipe.get_quantity())
	
	var requirements = recipe.get_recipe()
	
	for item in requirements:
		var slot = SLOT_CLASS.instance()
		slot.initialize_item(item[0], item[1])
		m_recipe_display.add_child(slot)
		
func craft() -> bool:
	var requirements = m_recipe.get_recipe()
	
	# check if items needed to craft exist in the inventory
	for item in requirements:
		if !Inventory.item_exists_in_inventory(item[0], item[1]):
			return false

	# if the items exists in the inventory, remove them from the inventory
	for item in requirements:
		Inventory.remove_item(item[0], item[1])
	
	# add the item to be crafted into the inventory
	Inventory.add_item(m_recipe.get_item_name(), m_recipe.get_quantity())
	
	return true

