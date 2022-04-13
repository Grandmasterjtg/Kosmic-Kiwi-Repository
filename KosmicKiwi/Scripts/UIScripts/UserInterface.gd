extends Control

const INVENTORY = "inventory"
const CRAFT = "craft"

onready var m_inventory_ui = $InventoryUI
onready var m_crafting_ui = $CraftingUI

func _process(delta: float) -> void:
	# player toggles inventory panel
	if Input.is_action_just_pressed(INVENTORY):
		toggle_menu(m_inventory_ui)
		close_menu(m_crafting_ui)
#		toggle_inventory()
#		close_crafting()
	if Input.is_action_just_pressed(CRAFT):
		toggle_menu(m_crafting_ui)
		close_menu(m_inventory_ui)
#		toggle_crafting()
#		close_inventory()

# takes a UI menu
# if the menu is closed, it sets the menu's visibility to true
func open_menu(menu) -> void:
	if menu != null and !menu.visible:
		menu.visible = true
		UIManager.open_menu()

# takes a UI menu
# if the menu is opend, it sets the menu's visibility to false
func close_menu(menu) -> void:
	if menu != null and menu.visible:
		menu.visible = false
		UIManager.close_menu()
		MouseManager.reset_mouse_texture()

# takes a UI menu
# opens or closes the menu based on whether it is already opened or closed
func toggle_menu(menu) -> void:
	if menu != null:
		if menu.visible:
			close_menu(menu)
		else:
			open_menu(menu)
