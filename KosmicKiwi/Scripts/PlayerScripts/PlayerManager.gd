extends Node

var m_player = null

func get_player():
	return m_player

func get_pos():
	if m_player != null:
		return m_player.global_position
	return null

func set_player(player):
	m_player = player
	
func show_bubble(item_name: String, texture) -> void:
	if m_player != null:
		m_player.show_bubble(item_name, texture)
