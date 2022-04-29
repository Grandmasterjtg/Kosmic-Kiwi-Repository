extends Control

const FOREST_TEXT = "Bright pinks and oranges, this planet is teeming with plant life!"
const WET_TEXT = "Muddy and moist, perfect conditions for life. Scanners indicate larger lifeforms roaming this planet!"
const JUNGLE_TEXT = "Swampy vines spotted with metal deposits, this planet looks hard to walk through!"
const DESERT_TEXT = "Dry and arid with rocky cliffs, this planet is dusty and windy!"
const WET_LOCKED_TEXT = "I need to find the ship's engine before I can travel to the Wet planet!"
const JUNGLE_LOCKED_TEXT = "I need to find the ship's engine before I can travel to the Junlge planet!"
const DESERT_LOCKED_TEXT = "I need to find the ship's solar sail and shield rings if I want to make it through that asteroid belt!"

onready var m_buttons = $Buttons.get_children()
onready var m_go_home_button = $GoHome
onready var m_nav_text = $TextPanel/Nav_Text

const FINAL_PART = "Warp Core"

export var m_start_visible := false
var m_close_button

func _ready():
	# simple checkmark for testing
	if m_start_visible:
		self.visible = true
	else:
		self.visible = false
	
	# setup close_button
	m_close_button = $CloseButton
	m_close_button.connect("pressed",self,"_on_CloseButton_pressed")
	update_buttons()
	
	# setup nav_text signals
	for button in m_buttons:
		button.connect("hovered",self,"_on_PlanetButton_hovered")

func _on_CloseButton_pressed():
	toggle_nav_menu()

func _on_PlanetButton_hovered(planet_index):
	match planet_index:
		0: # forest
			m_nav_text.text = FOREST_TEXT
		1: # jungle
			if PlanetManager.get_planet_at_index(planet_index).travelable():
				m_nav_text.text = JUNGLE_TEXT
			else:
				m_nav_text.text = JUNGLE_LOCKED_TEXT
		2: # wet
			if PlanetManager.get_planet_at_index(planet_index).travelable():
				m_nav_text.text = WET_TEXT
			else:
				m_nav_text.text = WET_LOCKED_TEXT
		3: # desert
			if PlanetManager.get_planet_at_index(planet_index).travelable():
				m_nav_text.text = DESERT_TEXT
			else:
				m_nav_text.text = DESERT_LOCKED_TEXT

func toggle_nav_menu():
	if visible:
		close_menu()
	elif UIManager.menus_closed():
		open_menu()
	
func open_menu():
	UIManager.open_menu()
	visible = true
	update_buttons()
	
func close_menu():
	UIManager.close_menu()
	visible = false

func update_buttons():
	PlanetManager.update_planets()
	for button in m_buttons:
		button.update_button()
	if Inventory.item_exists_in_inventory(FINAL_PART):
		m_go_home_button.visible = true
		
func show_go_home():
	m_go_home_button.visible = true
