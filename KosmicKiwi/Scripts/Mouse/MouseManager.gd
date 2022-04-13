extends Node


const DEFAULT_TEXTURE = null
var m_mouse_texture

signal mouse_updated(texture)
signal mouse_object_updated(object)


func _ready():
	pass

func set_mouse_texture(texture):
	m_mouse_texture = texture
	emit_signal("mouse_updated", m_mouse_texture)
	
func set_mouse_object(object):
	m_mouse_texture = object
	emit_signal("mouse_object_updated", m_mouse_texture)
	
func get_mouse_texture():
	return m_mouse_texture
	
func reset_mouse_texture():
	m_mouse_texture = DEFAULT_TEXTURE
	emit_signal("mouse_updated", m_mouse_texture)
