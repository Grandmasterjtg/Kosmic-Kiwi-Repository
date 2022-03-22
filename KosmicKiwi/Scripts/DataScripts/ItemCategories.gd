extends Node

var m_categories = [ # [ItemCategory, NumSlots]
	["Resource", 8],
	["Tool", 8],
	["ShipPart", 4]
]

# takes an index
# returns the string category at that index
func get_category(index: int) -> String:
	return m_categories[index][0]
	
func get_categories() -> Array:
	return m_categories.duplicate(true)
