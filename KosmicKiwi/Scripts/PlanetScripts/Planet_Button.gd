extends Control

onready var m_button = $Button
onready var m_label = $Label

export var m_label_text := "Planet Button"
export var m_planetPath := ""
export var m_texture : Texture
export var m_item_required := false
export var m_required_item_name := "Item"

func _ready() -> void:
	# setup button
	m_button.connect("pressed",self,"_on_Button_pressed")
	if (m_texture == null):
		m_texture = load("res://ArtAssets/UI/Planet1.png")
	else:
		m_button.icon = m_texture
	
	# setup label
	m_label.text = m_label_text

func _on_Button_pressed():
	get_tree().change_scene(m_planetPath)
	print(m_planetPath)

func set_active(state: bool):
	m_button.disabled = state
	match state:
		true:
			m_button.modulate = Color(1,1,1,0.5)
		false:
			m_button.modulate = Color(1,1,1)
