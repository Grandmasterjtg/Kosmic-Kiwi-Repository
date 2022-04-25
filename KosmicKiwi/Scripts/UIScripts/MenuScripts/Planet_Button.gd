extends Control

onready var m_button = $Button
onready var m_label = $Label

export var m_planet_index : int
var m_planet : Planet

export var m_texture : Texture

func _ready() -> void:
	# setup planet for this button
	m_planet = PlanetManager.m_planets[m_planet_index]
	
	# setup button signal and texture
	m_button.connect("pressed",self,"_on_Button_pressed")
	if (m_texture == null):
		m_texture = load("res://ArtAssets/UI/Planet1.png")
	else:
		m_button.icon = m_texture
	
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

func set_active(state: bool):
	m_button.disabled = !state
	match state:
		true:
			m_button.modulate = Color(1,1,1)
		false:
			m_button.modulate = Color(0.1,0.1,0.1,0.5)
