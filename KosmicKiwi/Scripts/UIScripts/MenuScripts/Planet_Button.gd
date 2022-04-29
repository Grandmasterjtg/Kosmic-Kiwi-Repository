extends Control

const DEFAULT_TEXTURE = preload("res://ArtAssets/Menu/Planets/F_PlanetB.png")

onready var m_button = $AspectRatioContainer/Button
onready var m_label = $Label

export var m_planet_index : int
export var m_hover_texture : Texture
export var m_normal_texture : Texture

var m_planet : Planet

signal hovered(planet_index)

func _ready() -> void:
	# setup planet for this button
	m_planet = PlanetManager.m_planets[m_planet_index]
	
	# setup button signals
	m_button.connect("pressed",self,"_on_Button_pressed")
	m_button.connect("mouse_entered",self,"_on_mouse_entered")
	
	# setup button textures
	if m_hover_texture == null:
		m_hover_texture = DEFAULT_TEXTURE
	m_button.texture_hover = m_hover_texture
	
	if m_normal_texture == null:
		m_normal_texture = DEFAULT_TEXTURE
	m_button.texture_normal = m_normal_texture
	
	# update button
	update_button()

func update_button():
	# update planet name and travelable state
	if (m_planet != null):
		m_label.text = m_planet.get_planet_name()
		set_active(m_planet.travelable())
	else:
		printerr("m_planet is null in " + self.name)

func _on_Button_pressed():
	if (m_planet != null):
		PlanetManager.set_active_planet(m_planet)
		FriendManager.set_current_friend_id(-1)
		Inventory.clear_inventory()
		LoadingManager.load_new_scene(m_planet.get_planet_path())
		print("PlanetManager set_active_planet: " + m_planet.get_planet_path())
	else:
		printerr("PlanetManager set_active_planet, m_active_planet is NULL")

func _on_mouse_entered():
	emit_signal("hovered",m_planet_index)

func set_active(state: bool):
	m_button.disabled = !state
	match state:
		true:
			m_button.modulate = Color(1,1,1)
		false:
			m_button.modulate = Color(0.1,0.1,0.1,0.5)
