extends Control

onready var m_master_slider = $"Panel/Master Slider"
onready var m_music_slider = $"Panel/Music Slider"
onready var m_sfx_slider = $"Panel/SFX Slider"

func _ready():
	m_master_slider.value = SoundManager.get_master_volume()
	m_music_slider.value = SoundManager.get_music_volume()
	m_sfx_slider.value = SoundManager.get_sfx_volume()

func _on_Master_Slider_value_changed(value):
	SoundManager.set_master_volume(value)

func _on_Music_Slider_value_changed(value):
	SoundManager.set_music_volume(value)

func _on_SFX_Slider_value_changed(value):
	SoundManager.set_sfx_volume(value)
