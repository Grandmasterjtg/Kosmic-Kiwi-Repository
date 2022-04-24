extends Control

onready var m_close_button = $CloseButton
onready var m_start_button = $StartButton

const LOOP = "Main"

const START_LEVEL_PATH = "res://Levels/Animatic.tscn"


func _process(delta):
	if Input.is_action_just_pressed("hotbar_1"):
		# play menu music
		SoundManager.play_loop(LOOP)

func _ready():
	m_close_button = $CloseButton
	m_close_button.connect("pressed",self,"_on_CloseButton_pressed")
	
	m_start_button = $StartButton
	m_start_button.connect("pressed",self,"_on_StartButton_pressed")
	
	# play menu music
	SoundManager.play_loop(LOOP)

func _on_CloseButton_pressed():
	get_tree().quit()

func _on_StartButton_pressed():
	print("StartButton pressed.")
	PlanetManager.set_active_planet(PlanetManager.get_planet_at_index(0))
	get_tree().change_scene(START_LEVEL_PATH)
