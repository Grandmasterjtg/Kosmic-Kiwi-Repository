extends Control

const ITEM_CLASS = preload("res://Scenes/UI/Inventory/ItemUI.tscn")
var m_item = null

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

# if an item exists, it deletes the node and sets the variable to null
func delete_item():
	if m_item != null:
		m_item.queue_free()
		m_item = null
