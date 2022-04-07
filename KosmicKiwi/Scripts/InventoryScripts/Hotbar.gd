extends Control

const ACTION_HOTBAR_1 := "hotbar_1"
const ACTION_HOTBAR_2 := "hotbar_2"
const ACTION_HOTBAR_3 := "hotbar_3"
const ACTION_HOTBAR_4 := "hotbar_4"
const ACTION_HOTBAR := "hotbar_"

const PLACE := "place"
const CANCEL := "cancel"

onready var m_hotbar_slots = $HotbarSlots.get_children()
const ITEM_CLASS = preload("res://Scenes/Interactables/Item.tscn")

var m_selected_slot = null

var m_showing_item = false

func _ready() -> void:
	Inventory.connect("inventory_updated", self, "update_hotbar")
	set_selected_slot(0)
	
func _input(event):
	for i in range(m_hotbar_slots.size()):
		var action = ACTION_HOTBAR + str(i+1)
		if event.is_action_pressed(action):
			set_selected_slot(i)
	
	if event.is_action_pressed(PLACE) and !m_showing_item and UIManager.menus_closed():
		show_item()
	if event.is_action_pressed(CANCEL) and m_showing_item:
		cancel_show()
	if event.is_action_released(PLACE) and m_showing_item and UIManager.menus_closed():
		place_item()

# updates the items displayed in the hotbar to the items in the Inventory's hotbar
# sets the selected item to the currently selected slot
func update_hotbar():
	# reset items in hotbar to emtpy
	for i in range(m_hotbar_slots.size()):
		m_hotbar_slots[i].delete_item()
	
	# get the items in the hotbar and the corresponding inventory slots
	var items = Inventory.get_items_in_hotbar()
#	var inventory_slots = Inventory.get_slots_in_hotbar()
	
	# instantiate the items into the hotbar
	for i in range(items.size()):
		var item_name = items[i][0]
		var item_quantity = items[i][1]
		print(item_name)
		m_hotbar_slots[i].initialize_item(item_name, item_quantity)
	
	# set the Inventory's selected item to the selected slot's item
	for i in range(m_hotbar_slots.size()):	
		if m_hotbar_slots[i] == m_selected_slot:
			set_selected_slot(i)

# takes an integer index
# sets the slot in the hotbar at that index to the selected slot
# updates the SlotUI and the Inventory's selected slot variable
func set_selected_slot(index: int) -> void:
	if m_selected_slot:
		m_selected_slot.set_selected(false)
	
	m_selected_slot = m_hotbar_slots[index]
	m_selected_slot.set_selected(true)
	
	if m_selected_slot.get_item():
		Inventory.set_selected_item(m_selected_slot.get_item().get_item_name())
	else:
		Inventory.set_selected_item(null)


func show_item():
	if m_selected_slot != null and m_selected_slot.get_item() != null:
		MouseManager.set_mouse_texture(m_selected_slot.get_item().texture)
		m_showing_item = true


func cancel_show():
	MouseManager.reset_mouse_texture()
	m_showing_item = false


func place_item():
	# null checks
	if m_selected_slot != null and m_selected_slot.get_item() != null:
		# the item in the selected slot
		var slot_item = m_selected_slot.get_item()
		# the in world item to be created
		var item = ITEM_CLASS.instance()
		# add the item to the scene
		get_tree().root.add_child(item)
		# initialize the item script to the correct item and position
		item.set_item(slot_item.get_item_name(), item.get_global_mouse_position())
		# remove the item from the inventory
		Inventory.remove_item(slot_item.get_item_name())
		
		# reset mouse cursor
		MouseManager.reset_mouse_texture()
		m_showing_item = false
		
