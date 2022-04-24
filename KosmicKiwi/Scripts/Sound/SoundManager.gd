extends Node2D

const MUSIC = "Music"
const SFX = "SFX"

var m_sound = preload("res://Sound/SFX/Crafting_SFX.wav")
var m_current_player = null
var m_musics = {
	"Forest": preload("res://Sound/Music/ForestRev2.wav"),
	"Jungle": preload("res://Sound/Music/JungleLoopV2.wav"),
	"Desert": preload("res://Sound/Music/DesertLoopV6.wav"),
	"Wet": preload("res://Sound/Music/WaterLoopV7.wav"),
	"Main": preload("res://Sound/Music/MelloBasic.wav"),
	"Synth": preload("res://Sound/Music/SynthBasic.wav")
}


# takes the name of the loop to play
# sets up the audio player with the correct song
func play_loop(music_name: String) -> void:
	# if no auio stream player, set up audio stream player
	# set the bus to music
	if m_current_player == null:
		m_current_player = AudioStreamPlayer.new()
		m_current_player.set_bus(MUSIC)
		m_current_player.pause_mode = Node.PAUSE_MODE_PROCESS
		add_child(m_current_player)
	
	# if the song exists
	if m_musics.has(music_name):
		m_current_player.stream = m_musics[music_name]
		m_current_player.play()

# stops the currently running loop
func stop_loop():
	if m_current_player != null:
		m_current_player.stop()
	

# takes an integer?/float? volume
# sets the master audio server's volume to the passed volume
func set_master_volume(volume) -> void:
	AudioServer.set_bus_volume_db(0, volume)
	
# takes an integer?/float? volume
# sets the music audio server's volume to the passed volume
func set_music_volume(volume) -> void:
	AudioServer.set_bus_volume_db(1, volume)

# takes an integer?/float? volume
# sets the sfx audio server's volume to the passed volume
func set_sfx_volume(volume) -> void:
	AudioServer.set_bus_volume_db(2, volume)
