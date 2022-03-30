extends Control

const CLICK = "Press"

export var m_is_interactable := false

# textures
const TEXTURE_PATH := "res://ArtAssets/InventorySlots/"
const TEXTURE_TYPE := ".png"

const EMPTY_SLOT = preload("res://ArtAssets/InventorySlots/Empty.png")

var style : StyleBoxTexture = null


const TOOL_SLOT = preload("res://ArtAssets/InventorySlots/Tool.png")
const SHIP_SLOT = preload("res://ArtAssets/InventorySlots/ShipPart.png")
const RESOURCE_SLOT = preload("res://ArtAssets/InventorySlots/Resource.png")
const SELECTED_SLOT = preload("res://ArtAssets/InventorySlots/Selected.png")

const ITEM_CLASS = preload("res://Scenes/UI/Inventory/ItemUI.tscn")
var m_item = null

var m_slot_number := 0

func _ready():
	style = StyleBoxTexture.new()
	style.texture = EMPTY_SLOT
	set("custom_styles/panel", style)

# takes an item name and the amount of that item
# sets the slots ItemUI to the inputted item
func initialize_item(item_name: String, item_quantity: int) -> void:
	# if item already exists
	if m_item != null:
		m_item.set_item(item_name, item_quantity)
	# if no item exists
	else:
		m_item = ITEM_CLASS.instance()
		add_child(m_item)
		m_item.set_item(item_name, item_quantity)
		
		# set the scale of the item to match the size of the slot
		var scale = rect_min_size.x / m_item.rect_size.x
		m_item.rect_scale *= scale
		
	# set slot style
	var item_texture = load(TEXTURE_PATH + ItemData.get_category(item_name) + TEXTURE_TYPE)
	if item_texture and style:
		style.texture = item_texture

# if an item exists, it deletes the node and sets the variable to null
func delete_item():
	if m_item != null:
		m_item.queue_free()
		m_item = null
		style.texture = EMPTY_SLOT
		
func _gui_input(event):
	if event.is_action_pressed(CLICK) and m_item != null and m_is_interactable:
		if Inventory.item_exists_in_hotbar(m_item.get_item_category(), m_slot_number):
			Inventory.remove_from_hotbar(m_item.get_item_category(), m_slot_number)
		else:
			Inventory.add_to_hotbar(m_item.get_item_category(), m_slot_number)
		
func set_slot_number(index: int) -> void:
	m_slot_number = index
func set_is_interactable(is_interactable: bool) -> void:
	m_is_interactable = is_interactable
	
func get_item():
	return m_item
