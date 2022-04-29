extends TextureButton


const SCENE_TO_LOAD := "res://Levels/EndScreen.tscn"
const PLANET_INDEX := 4

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("button_down", self, "on_button_down")


func on_button_down():
	PlanetManager.set_active_planet(PlanetManager.get_planet_at_index(PLANET_INDEX))
	LoadingManager.load_new_scene(SCENE_TO_LOAD)
