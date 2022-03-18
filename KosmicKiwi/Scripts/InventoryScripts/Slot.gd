extends Control

const ITEM_CLASS = preload("res://Scenes/UI/Inventory/ItemUI.tscn")
var m_item = null
		
func _process(delta : float) -> void:
	if Input.is_action_just_pressed("move_down"):
		initialize_item("Tree Branch", 5)
		
func initialize_item(item_name: String, item_quantity: int) -> void:
	if m_item != null:
		m_item.set_item(item_name, item_quantity)
	else:
		m_item = ITEM_CLASS.instance()
		add_child(m_item)
		m_item.set_item(item_name, item_quantity)
