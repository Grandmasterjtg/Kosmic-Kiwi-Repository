extends AnimatedSprite

const CANCEL = "cancel"
const CONTINUE = "place"

var m_current_index = 0

var m_frames = [
	"0",
	"1",
	"2",
	"3",
	"4",
	"5",
	"6"
]

# skip the animatic if the player wants
func _process(delta):
	if Input.is_action_just_pressed(CANCEL):
		load_game()
	if Input.is_action_just_pressed(CONTINUE):
		next_frame()

# displays the next image in the animatic
# loads the first planet if the end is reached
func next_frame():
	if m_current_index < len(m_frames) - 1:
		m_current_index += 1
		play(m_frames[m_current_index])
	else:
		load_game()

# loads the first planet in the planet manager script
func load_game():
	LoadingManager.load_new_scene(PlanetManager.get_planet_at_index(0).get_planet_path())
	
