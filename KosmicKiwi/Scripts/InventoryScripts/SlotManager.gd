extends GridContainer

const SLOT_CLASS = preload("res://Scenes/UI/Inventory/Slot.tscn")

export var m_category_index : int
var m_category : String

func _ready() -> void:
	m_category = ItemCategories.get_category(m_category_index)
	
	# instantiate the slots in the inventory section
	var num_slots = ItemCategories.get_num_slots(m_category_index)
	for i in range(num_slots):
		var slot = SLOT_CLASS.instance()
		slot.set_slot_number(i)
		slot.set_is_interactable(ItemCategories.get_is_interactable(m_category_index))
		add_child(slot)

func get_category() -> String:
	return m_category
