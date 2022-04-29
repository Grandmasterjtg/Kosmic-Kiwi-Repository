extends Control

onready var m_friend_texture = $Panel/AspectRatioContainer/TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_texture(texture: Texture):
	m_friend_texture.texture = texture

func get_texture() -> Texture:
	return m_friend_texture
