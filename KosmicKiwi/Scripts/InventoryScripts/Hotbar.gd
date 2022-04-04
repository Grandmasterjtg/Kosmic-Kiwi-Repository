extends Control

const ACTION_HOTBAR_1 := "hotbar_1"
const ACTION_HOTBAR_2 := "hotbar_2"
const ACTION_HOTBAR_3 := "hotbar_3"
const ACTION_HOTBAR_4 := "hotbar_4"

onready var m_hotbar_slots = $HotbarSlots.get_children()
const ITEM_CLASS = preload("res://Scenes/Interactables/Item.tscn")

var selected_slot = null

func _ready() -> void:
	Inventory.connect("inventory_updated", self, "update_hotbar")
	set_selected_slot(0)
	
func _input(event):
	if event.is_action_pressed(ACTION_HOTBAR_1):
		set_selected_slot(0)
		place_item(0)
	if event.is_action_pressed(ACTION_HOTBAR_2):
		set_selected_slot(1)
		place_item(1)
	if event.is_action_pressed(ACTION_HOTBAR_3):
		set_selected_slot(2)
		place_item(2)
	if event.is_action_pressed(ACTION_HOTBAR_4):
		set_selected_slot(3)
		place_item(3)
	
func update_hotbar():
	# reset items in hotbar to emtpy
	for i in range(m_hotbar_slots.size()):
		m_hotbar_slots[i].delete_item()
	
	# get the items in the hotbar and the corresponding inventory slots
	var items = Inventory.get_items_in_hotbar()
	var inventory_slots = Inventory.get_slots_in_hotbar()
	
	# instantiate the items into the hotbar
	for i in range(items.size()):
		var item_name = items[i][0]
		var item_quantity = items[i][1]
		m_hotbar_slots[i].initialize_item(item_name, item_quantity)
		m_hotbar_slots[i].set_slot_number(inventory_slots[i][1])
		
func set_selected_slot(index: int) -> void:
	if selected_slot:
		selected_slot.set_selected(false)
	
	selected_slot = m_hotbar_slots[index]
	selected_slot.set_selected(true)
		
func place_item(index: int):
	var slot_item = m_hotbar_slots[index].get_item()

	if slot_item != null and ItemData.is_placeable(slot_item.get_item_name()):
		var item = ITEM_CLASS.instance()
		item.set_item(slot_item.get_item_name(), get_parent().get_parent().get_child(1).position)
		Inventory.remove_item(slot_item.get_item_name())
		get_tree().root.add_child(item)
		
