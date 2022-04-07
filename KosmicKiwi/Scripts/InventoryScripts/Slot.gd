extends Control

const CLICK = "place"

# textures
const TEXTURE_PATH := "res://ArtAssets/InventorySlots/"
const TEXTURE_TYPE := ".png"

const EMPTY_SLOT := preload("res://ArtAssets/InventorySlots/Empty.png")
const SELECTED_SLOT := preload("res://ArtAssets/InventorySlots/Selected.png")

# styleboxes
var default_style : StyleBoxTexture = null
var selected_style : StyleBoxTexture = null

# item variables
const ITEM_CLASS = preload("res://Scenes/UI/Inventory/ItemUI.tscn")
var m_item_ui = null

# data variables
var m_slot_number := 0
var m_is_selected := false
export var m_is_interactable := false

func _ready():
	default_style = StyleBoxTexture.new()
	default_style.texture = EMPTY_SLOT
	set("custom_styles/panel", default_style)
	
	selected_style = StyleBoxTexture.new()
	selected_style.texture = SELECTED_SLOT

# takes an item name and the amount of that item
# sets the slots ItemUI to the inputted item
func initialize_item(item_name: String, item_quantity: int) -> void:
	# if item already exists
	if m_item_ui != null:
		m_item_ui.set_item(item_name, item_quantity)
	# if no item exists
	else:
		m_item_ui = ITEM_CLASS.instance()
		add_child(m_item_ui)
		m_item_ui.set_item(item_name, item_quantity)
		
		# set the scale of the item to match the size of the slot
		var scale = rect_min_size.x / m_item_ui.rect_size.x
		m_item_ui.rect_scale *= scale
		
	# set slot style
#	var item_texture = load(TEXTURE_PATH + ItemData.get_category(item_name) + TEXTURE_TYPE)
#	if item_texture and default_style:
#		default_style.texture = item_texture

# if an item exists, it deletes the node and sets the variable to null
func delete_item():
	if m_item_ui != null:
		m_item_ui.queue_free()
		m_item_ui = null
		default_style.texture = EMPTY_SLOT

# checks for if the slot has been interacted by the mouse
# adds the item to the hotbar when interact is detected
func _gui_input(event):
	if event.is_action_pressed(CLICK) and m_item_ui != null and m_is_interactable:
		if Inventory.item_exists_in_hotbar(m_item_ui.get_item_name()):
			Inventory.remove_from_hotbar(m_item_ui.get_item_name())
		else:
			Inventory.add_to_hotbar(m_item_ui.get_item_name())

# setter for slot number
func set_slot_number(index: int) -> void:
	m_slot_number = index
# setter for is interactable
func set_is_interactable(is_interactable: bool) -> void:
	m_is_interactable = is_interactable

# takes a bool value for wether or not the slot should be selected
# sets the stylebox of the slot to the corresponding stylebox
func set_selected(is_selected: bool) -> void:
	if is_selected:
		set("custom_styles/panel", selected_style)
	else:
		set("custom_styles/panel", default_style)
	
func get_item():
	return m_item_ui
