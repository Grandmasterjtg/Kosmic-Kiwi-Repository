extends Node

var m_loading_menu = "res://Scenes/UI/Loading/LoadingUI.tscn"

var m_scene_to_load = null

func load_new_scene(new_scene):
	m_scene_to_load = new_scene
	if m_scene_to_load != null:
		get_tree().change_scene(m_loading_menu)
		
func get_scene_to_load():
	return m_scene_to_load
	
