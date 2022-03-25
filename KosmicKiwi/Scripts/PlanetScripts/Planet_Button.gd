extends Control

onready var m_button = $Button
export var planetPath = ""

func _ready() -> void:
	m_button.connect("pressed",self,"_on_Button_pressed")

func _on_Button_pressed():
	get_tree().change_scene(planetPath)
	print(planetPath)
