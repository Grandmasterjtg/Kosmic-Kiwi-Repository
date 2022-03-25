extends Control

var m_close_button
var m_start_button
export var first_level_path = "res://Levels/TestInteraction.tscn"

func _ready():
	m_close_button = $CloseButton
	m_close_button.connect("pressed",self,"_on_CloseButton_pressed")
	
	m_start_button = $StartButton
	m_close_button.connect("pressed",self,"_on_StartButton_pressed")

func _on_CloseButton_pressed():
	get_tree().quit()

func _on_StartButton_pressed():
	get_tree().change_scene(first_level_path)
