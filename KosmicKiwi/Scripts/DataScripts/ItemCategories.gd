extends Node

var m_categories = [ # [ItemCategory, NumSlots, IsInteractable]
	["Resource", 8, true],
	["Tool", 8, true],
	["ShipPart", 4, false]
]

# takes an index
# returns the string category at that index
func get_category(index: int) -> String:
	return m_categories[index][0]
	
# takes an index
# returns the int number of slots at that index
func get_num_slots(index: int) -> int:
	return m_categories[index][1]
	
func get_is_interactable(index: int) -> bool:
	return m_categories[index][2]

# returns a copy of the categories array
func get_categories() -> Array:
	return m_categories.duplicate(true)


