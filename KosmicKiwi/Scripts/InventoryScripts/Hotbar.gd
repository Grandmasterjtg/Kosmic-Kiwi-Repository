extends Control

onready var m_hotbar_slots = $HotbarSlots
const ITEM_CLASS = preload("res://Levels/Test.tscn")

func _ready() -> void:
	Inventory.connect("inventory_updated", self, "update_hotbar")
	
func _process(delta):
	# check for input
	# place_item(index: int) 1 2 3 4
	pass
	
func update_hotbar():
	var slots = m_hotbar_slots.get_children()
	for i in range(slots.size()):
		slots[i].delete_item()
	
	
	var items = Inventory.get_items_in_hotbar()
	var inventory_slots = Inventory.get_slots_in_hotbar()
	
	for i in range(items.size()):
		var item_name = items[i][0]
		var item_quantity = items[i][1]
		slots[i].initialize_item(item_name, item_quantity)
		slots[i].set_slot_number(inventory_slots[i][1])
		
func place_item(index: int):
	pass
#	var slots = m_hotbar_slots.get_children()
#	var slot_item = slots[index].get_item()
#
#	if slot_item != null:
#		var item = ITEM_CLASS.instance()
#		item.set_item(slots[index].get_name())
#		Inventory.remove_item(item.get_name())
#		get_tree().root.add_child(item)
		
	
