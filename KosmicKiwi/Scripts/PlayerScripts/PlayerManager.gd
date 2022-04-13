extends Node

var m_default_texture # preload("emote_path")
var m_happy_texture
var m_sad_texture
var m_thinking_texture
var m_success_texture
var m_fail_texture

enum Emote {HAPPY, SAD, THINKING}

func get_player():
	if !get_tree().get_nodes_in_group("player").empty():
		return get_tree().get_nodes_in_group("player")[0]
	else: 
		return null

func get_pos():
	var player = get_player()
	if player != null:
		return player.global_position
	else:
		return null
	
func show_bubble(item_name: String, texture) -> void:
	var player = get_player().get_node("PlayerBody")
	if player != null:
		player.show_bubble(item_name, texture)

func emote_with_texture(texture: Texture):
	pass

func play_emote(emote: int):
	# decide the texture for the emote
	match emote:
		Emote.HAPPY:
			pass
		Emote.SAD:
			pass
		Emote.THINKING:
			pass
