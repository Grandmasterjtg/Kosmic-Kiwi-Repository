extends Control

var m_default_scene = "res://Scenes/Menu_Scenes/MainMenu.tscn"
var m_scene_to_load = null

var m_loader
onready var m_progress_bar = $ProgressBar

var m_progress = []
var m_scene_load_status = 0

func _ready():
	m_scene_to_load = LoadingManager.get_scene_to_load()
	if m_scene_to_load != null:
		m_loader = ResourceLoader.load_interactive(m_scene_to_load)
	else:
		m_scene_to_load = m_default_scene
		m_loader = ResourceLoader.load_interactive(m_scene_to_load)
		
func _process(delta):
	var err = m_loader.poll()
	if err == ERR_FILE_EOF:
		var resource = m_loader.get_resource()
		get_tree().change_scene_to(resource)
		queue_free()
	if err == OK:
		var progress = float(m_loader.get_stage())/m_loader.get_stage_count()
		m_progress_bar.value = progress*100
