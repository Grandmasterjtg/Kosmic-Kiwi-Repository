extends Control

var m_default_scene = "res://Scenes/Menu_Scenes/MainMenu.tscn"
var m_scene_to_load = null

var m_loader
onready var m_progress_bar = $ProgressBar
onready var m_ship = $ProgressBar/Ship

var m_progress = []
var m_scene_load_status = 0

func _ready():
	# set up loading new scene
	m_scene_to_load = LoadingManager.get_scene_to_load()
	# if the loading manager has a scene to load
	if m_scene_to_load != null:
		m_loader = ResourceLoader.load_interactive(m_scene_to_load)
	# load the default scene
	else:
		m_scene_to_load = m_default_scene
		m_loader = ResourceLoader.load_interactive(m_scene_to_load)
		
	# set up planets
	# update the texture of the planet beign traveled from
	if PlanetManager.get_previous_planet() != null and PlanetManager.get_active_planet() != PlanetManager.get_previous_planet():
		$Planet1.texture = PlanetManager.get_previous_planet().get_texture()
	else:
		$Planet1.texture = null
	
	# update the texture to the planet being traveled to
	if PlanetManager.get_active_planet() != null:
		$Planet2.texture = PlanetManager.get_active_planet().get_texture()
	else:
		$Planet2.texture = null

func _process(delta):
	var err = m_loader.poll()
	# if the scene if fully loaded
	if err == ERR_FILE_EOF:
		var resource = m_loader.get_resource()
		get_tree().change_scene_to(resource)
		queue_free()
	# if the scene is still loading
	if err == OK:
		var progress = float(m_loader.get_stage())/m_loader.get_stage_count()
		# update the ship's position
		m_ship.rect_position.x = m_progress_bar.rect_size.x * progress
		# update the progress bar
		m_progress_bar.value = progress*100
