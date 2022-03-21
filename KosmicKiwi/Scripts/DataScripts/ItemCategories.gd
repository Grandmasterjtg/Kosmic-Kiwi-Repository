extends Node

var m_categories = [
	["Resource", 8],
	["Tool", 8],
	["ShipPart", 4]
]

func category(index: int) -> String:
	return m_categories[index][0]
