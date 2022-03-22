extends Control

onready var m_hotbar_slots = $HotbarSlots

func _ready() -> void:
	Inventory.connect("inventory_updated", self, "update_hotbar")
	
func update_hotbar():
	var slots = m_hotbar_slots.get_children()
	for i in range(slots.size()):
		slots[i].delete_item()
	
	var items = Inventory.get_items_in_hotbar()
	for i in range(items.size()):
		var item_name = items[i][0]
		var item_quantity = items[i][1]
		slots[i].initialize_item(item_name, item_quantity)
	
	
	
#	for i in range(slots.size()):
#		if Inventory.hotbar_has_item_at(i):
#			var item_name = Inventory.get_hotbar_item_name(i)
#			var item_quantity = Inventory.get_hotbar_item_quantity(i)
#			slots[i].initialize_item(item_name, item_quantity)
