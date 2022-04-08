extends Control

onready var m_close_button = $CloseButton
onready var m_start_button = $StartButton

const START_LEVEL_PATH = "res://Levels/Level_1_Planet_1.tscn"

func _ready():
	m_close_button = $CloseButton
	m_close_button.connect("pressed",self,"_on_CloseButton_pressed")
	
	m_start_button = $StartButton
	m_start_button.connect("pressed",self,"_on_StartButton_pressed")

func _on_CloseButton_pressed():
	get_tree().quit()

func _on_StartButton_pressed():
	print("StartButton pressed.")
	PlanetManager.set_active_planet(PlanetManager.get_planet_at_index(2))
	get_tree().change_scene(START_LEVEL_PATH)
