extends Node

func _input(event):
	if event.is_action_pressed("cheat"):
		for item_name in ItemData.m_data:
			Inventory.add_item(item_name, 5)
