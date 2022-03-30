extends Control

var m_close_button
onready var m_buttons = $Buttons.get_children()

func _ready():
	m_close_button = $CloseButton
	m_close_button.connect("pressed",self,"_on_CloseButton_pressed")
	PlanetManager.update_planets()
	update_buttons()

func _on_CloseButton_pressed():
	toggle_nav_menu()

func toggle_nav_menu():
	visible = !visible
	PlanetManager.update_planets()
	update_buttons()

func update_buttons():
	for button in m_buttons:
		button.update_button()
