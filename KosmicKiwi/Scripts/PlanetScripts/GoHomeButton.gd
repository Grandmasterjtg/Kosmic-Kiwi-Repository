extends TextureButton


const SCENE_TO_LOAD := "res://Levels/EndScreen.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("button_down", self, "on_button_down")


func on_button_down():
	LoadingManager.load_new_scene(SCENE_TO_LOAD)
