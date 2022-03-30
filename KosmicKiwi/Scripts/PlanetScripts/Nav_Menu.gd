extends Control

var m_close_button
onready var m_buttons = $Buttons.get_children()

func _ready():
	m_close_button = $CloseButton
	m_close_button.connect("pressed",self,"_on_CloseButton_pressed")
	update_buttons()

func _on_CloseButton_pressed():
	toggle_nav_menu()

func toggle_nav_menu():
	visible = !visible
	update_buttons()

func update_buttons():
	for button in m_buttons:
		if (button.m_item_required):
			# var thisButton = button.get_node("Button")
			button.set_active(ProgressionManager.check_for_ship_part(button.m_required_item_name))
