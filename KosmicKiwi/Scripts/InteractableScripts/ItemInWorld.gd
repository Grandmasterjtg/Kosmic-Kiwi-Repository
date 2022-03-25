extends AnimatedSprite

const FOLDER_PATH = "res://ArtAssets/SpriteFrames/"
const FILE_TYPE = ".tres"

var m_item_name : String

func set_item(name : String, pos : Vector2):
	global_position = pos
	m_item_name = name
	frames = load(FOLDER_PATH + name + FILE_TYPE)
	play("default")

func get_item_name() -> String:
	return m_item_name
