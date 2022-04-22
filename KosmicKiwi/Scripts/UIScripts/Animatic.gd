extends TextureRect

const CANCEL = "cancel"

var m_current_index = 0

var m_frames = [
	preload("res://ArtAssets/Animatic/Kiwipage1.png"),
	preload("res://ArtAssets/Animatic/Kiwipage2.png"),
	preload("res://ArtAssets/Animatic/Kiwipage3.png"),
	preload("res://ArtAssets/Animatic/Kiwipage4.png"),
	preload("res://ArtAssets/Animatic/Kiwipage5.png"),
	preload("res://ArtAssets/Animatic/Kiwipage6.png"),
	preload("res://ArtAssets/Animatic/Kiwipage7.png"),
	preload("res://ArtAssets/Animatic/Kiwipage8.png")
]

onready var m_timer = $Timer

func _ready():
	m_timer.connect("timeout", self, "next_frame")
	
	if !m_frames.empty():
		texture = m_frames[0]
		m_timer.start()

# skip the animatic if the player wants
func _process(delta):
	if Input.is_action_just_pressed(CANCEL):
		load_game()

# displays the next image in the animatic
# loads the first planet if the end is reached
func next_frame():
	if m_current_index < len(m_frames) - 1:
		m_current_index += 1
		texture = m_frames[m_current_index]
	else:
		LoadingManager.load_new_scene(PlanetManager.get_planet_at_index(0).get_planet_path())

# loads the first planet in the planet manager script
func load_game():
	LoadingManager.load_new_scene(PlanetManager.get_planet_at_index(0).get_planet_path())
	
