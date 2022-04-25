extends Control

const SLOT_CLASS = preload("res://Scenes/UI/Inventory/Slot.tscn")

export var m_category : String

func _ready() -> void:
	# instantiate the slots in the inventory section
	var num_slots = InventoryData.get_num_slots(m_category)
	for i in range(num_slots):
		var slot = SLOT_CLASS.instance()
		add_child(slot)
		slot.set_slot_number(i)
		slot.set_is_interactable(InventoryData.get_is_interactable(m_category))
		

func get_category() -> String:
	return m_category
