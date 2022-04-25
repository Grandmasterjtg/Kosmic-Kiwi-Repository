extends Control

const INVENTORY = "inventory"
const CRAFT = "craft"

const DEFAULT_SIZE := 1599
const SMALL_SIZE := 733

onready var m_inventory_ui = $InventoryUI
onready var m_crafting_ui = $CraftingUI

func _process(delta: float) -> void:
	# player toggles inventory panel
	if UIManager.menus_closed() or m_crafting_ui.visible or m_inventory_ui.visible:
		if Input.is_action_just_pressed(INVENTORY):
			toggle_inventory()
			#toggle_menu(m_inventory_ui)
			# close_menu(m_crafting_ui)
		if Input.is_action_just_pressed(CRAFT):
			toggle_crafting()
			# toggle_menu(m_crafting_ui)
			# close_menu(m_inventory_ui)

func open_inventory() -> void:
	if !m_inventory_ui.visible:
		m_inventory_ui.visible = true
		UIManager.open_menu()
		
func close_inventory() -> void:
	if m_inventory_ui.visible:
		m_inventory_ui.visible = false
		UIManager.close_menu()
		MouseManager.reset_mouse_texture()
		
func open_crafting() -> void:
	if !m_crafting_ui.visible:
		m_crafting_ui.visible = true
		UIManager.open_menu()
		$InventoryUI/Panel.rect_size.x = SMALL_SIZE
		for label in $InventoryUI/Panel/Labels.get_children():
			label.visible = false
		
func close_crafting() -> void:
	if m_crafting_ui.visible:
		m_crafting_ui.visible = false
		UIManager.close_menu()
		$InventoryUI/Panel.rect_size.x = DEFAULT_SIZE
		for label in $InventoryUI/Panel/Labels.get_children():
			label.visible = true
		MouseManager.reset_mouse_texture()
		
func toggle_inventory():
	if m_inventory_ui.visible:
		if m_crafting_ui.visible:
			close_crafting()
		else:
			close_inventory()
	else:
		open_inventory()
		
func toggle_crafting():
	if m_crafting_ui.visible:
		close_crafting()
		close_inventory()
	else:
		open_crafting()
		open_inventory()
		
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
