extends Node

var m_player = null

func set_player(player):
	m_player = player
	
func show_bubble(item_name: String, texture) -> void:
	print("PlayerManager")
	if m_player != null:
		m_player.show_bubble(item_name, texture)
