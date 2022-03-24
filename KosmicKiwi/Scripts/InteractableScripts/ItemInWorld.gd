extends AnimatedSprite

const FOLDER_PATH = "res://ArtAssets/SpriteFrames/"
const FILE_TYPE = ".tres"

var m_item_name : String

func set_item(name : String):
	global_position = Vector2(100, 100)
	m_item_name = name
	frames = load(FOLDER_PATH + name + FILE_TYPE)
	play("default")
