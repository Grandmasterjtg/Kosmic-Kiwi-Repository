extends Control

const CLICK = "Press"

export var m_is_interactable := true

const ITEM_CLASS = preload("res://Scenes/UI/Inventory/ItemUI.tscn")
var m_item = null

var m_slot_number := 0

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
		var scale = rect_size.x / m_item.rect_size.x
		m_item.rect_scale *= scale

# if an item exists, it deletes the node and sets the variable to null
func delete_item():
	if m_item != null:
		m_item.queue_free()
		m_item = null
		
func _gui_input(event):
	if event.is_action_pressed(CLICK) and m_item != null and m_is_interactable:
		if Inventory.item_exists_in_hotbar(m_item.get_item_category(), m_slot_number):
			print("1")
			Inventory.remove_from_hotbar(m_item.get_item_category(), m_slot_number)
		else:
			Inventory.add_to_hotbar(m_item.get_item_category(), m_slot_number)
			print("2")
		
func set_slot_number(index: int) -> void:
	m_slot_number = index
func set_is_interactable(is_interactable: bool) -> void:
	m_is_interactable = is_interactable
