extends Control

var m_close_button

func _ready():
	m_close_button = $CloseButton
	m_close_button.connect("pressed",self,"_on_CloseButton_pressed")

func _on_CloseButton_pressed():
	toggle_nav_menu()

func toggle_nav_menu():
	visible = !visible
