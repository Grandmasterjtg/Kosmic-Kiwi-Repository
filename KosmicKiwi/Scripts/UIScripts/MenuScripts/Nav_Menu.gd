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
	if visible:
		close_menu()
	elif UIManager.menus_closed():
		open_menu()
	
func open_menu():
	UIManager.open_menu()
	visible = true
	update_buttons()
	
func close_menu():
	UIManager.close_menu()
	visible = false

func update_buttons():
	PlanetManager.update_planets()
	for button in m_buttons:
		button.update_button()
