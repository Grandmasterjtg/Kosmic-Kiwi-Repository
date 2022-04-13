extends Control

const INVENTORY = "inventory"
const CRAFT = "craft"

onready var m_inventory_ui = $InventoryUI
onready var m_crafting_ui = $CraftingUI

func _process(delta: float) -> void:
	# player toggles inventory panel
	if Input.is_action_just_pressed(INVENTORY):
		toggle_inventory()
		close_crafting()
	if Input.is_action_just_pressed(CRAFT):
		toggle_crafting()
		close_inventory()
		
func open_inventory() -> void:
	if !m_inventory_ui.visible:
		m_inventory_ui.visible = true
		UIManager.open_menu()

func close_inventory() -> void:
	if m_inventory_ui.visible:
		m_inventory_ui.visible = false
		UIManager.close_menu()
		
func toggle_inventory() -> void:
	if m_inventory_ui.visible:
		close_inventory()
	else:
		open_inventory()

func open_crafting() -> void:
	if !m_crafting_ui.visible:
		m_crafting_ui.visible = true
		UIManager.open_menu()
		
func close_crafting() -> void:
	if m_crafting_ui.visible:
		m_crafting_ui.visible = false
		UIManager.close_menu()
		
func toggle_crafting() -> void:
	if m_crafting_ui.visible:
		close_crafting()
	else:
		open_crafting()
