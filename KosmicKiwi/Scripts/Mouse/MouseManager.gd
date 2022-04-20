extends Node2D


const DEFAULT_TEXTURE = preload("res://ArtAssets/UI/Cursor.png")
const RANGE = 1000
var m_mouse_texture

signal mouse_updated(texture)
signal mouse_object_updated(object)
signal new_clamp(value)


func set_mouse_texture(texture):
	m_mouse_texture = texture
	emit_signal("mouse_updated", m_mouse_texture)

func set_mouse_object(object):
	m_mouse_texture = object
	emit_signal("mouse_object_updated", m_mouse_texture)
	
func get_item_direction():
	return PlayerManager.get_pos().direction_to(self.get_global_mouse_position())
	
func get_item_distance():
	return min(PlayerManager.get_pos().distance_to(self.get_global_mouse_position()), RANGE)
	
func get_mouse_pos():
	return self.get_global_mouse_position()

func get_mouse_texture():
	return m_mouse_texture
	
func reset_mouse_texture():
	m_mouse_texture = DEFAULT_TEXTURE
	emit_signal("mouse_updated", m_mouse_texture)

func set_clamp(value : bool):
	emit_signal("new_clamp", value)
