extends Node2D

var m_sound = preload("res://Sound/SFX/Crafting_SFX.wav")
var m_current_player = null

func test() -> void:
	var player = AudioStreamPlayer.new()
	m_current_player = player
	add_child(player)
	
	if m_current_player != null:
		m_current_player.queue_free()
	
	player.stream = m_sound
	player.play()
	

# takes an integer?/float? volume
# sets the master audio server's volume to the passed volume
func set_master_volume(volume) -> void:
	AudioServer.set_bus_volume_db(0, volume)
