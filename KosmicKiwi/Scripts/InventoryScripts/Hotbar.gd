extends Control

const ACTION_HOTBAR_1 := "hotbar_1"
const ACTION_HOTBAR_2 := "hotbar_2"
const ACTION_HOTBAR_3 := "hotbar_3"
const ACTION_HOTBAR_4 := "hotbar_4"

onready var m_hotbar_slots = $HotbarSlots
const ITEM_CLASS = preload("res://Scenes/Interactables/Item.tscn")

func _ready() -> void:
	Inventory.connect("inventory_updated", self, "update_hotbar")
	
func _input(event):
	if event.is_action_pressed(ACTION_HOTBAR_1):
		place_item(0)
	if event.is_action_pressed(ACTION_HOTBAR_2):
		place_item(1)
	if event.is_action_pressed(ACTION_HOTBAR_3):
		place_item(2)
	if event.is_action_pressed(ACTION_HOTBAR_4):
		place_item(3)
	
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
	var slots = m_hotbar_slots.get_children()
	var slot_item = slots[index].get_item()

	if slot_item != null and ItemData.is_placeable(slot_item.get_item_name()):
		var item = ITEM_CLASS.instance()
		item.set_item(slot_item.get_item_name(), get_viewport().get_mouse_position())
		Inventory.remove_item(slot_item.get_item_name())
		get_tree().root.add_child(item)
		
