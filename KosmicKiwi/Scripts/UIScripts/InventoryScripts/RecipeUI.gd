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
	
	for i in range(recipe.size()):
		var slot = SLOT_CLASS.instance()
		m_recipe_display.add_child(slot)
		slot.initialize_item(recipe.get_required_item(i), recipe.get_required_amount(i))
		
		
func craft() -> bool:
	var item_name = m_recipe.get_item_name()
	# if the inventory contains less than the maximum amount of the item to craft
	if !Inventory.item_exists_in_inventory(item_name, ItemData.get_stack_size(item_name)):
		# check if items needed to craft exist in the inventory
		for i in range(m_recipe.size()):
			# if there isn't enough of the item in the inventory
			if !Inventory.item_exists_in_inventory(
					m_recipe.get_required_item(i), m_recipe.get_required_amount(i) ):
				return false

		# remove the required items from the inventory
		for i in range(m_recipe.size()):
			Inventory.remove_item(m_recipe.get_required_item(i), m_recipe.get_required_amount(i))
		
		# add the item to be crafted into the inventory
		Inventory.add_item(m_recipe.get_item_name(), m_recipe.get_quantity())
		
		$CraftSFX.play()
		
		return true
	else:
		return false

