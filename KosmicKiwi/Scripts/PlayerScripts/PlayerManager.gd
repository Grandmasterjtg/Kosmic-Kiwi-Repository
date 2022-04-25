extends Node

var m_default_texture # preload("emote_path")
var m_happy_texture
var m_sad_texture
var m_thinking_texture
var m_success_texture
var m_fail_texture

enum Emote {HAPPY, SAD, THINKING, SUCCESS, FAIL}

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
	var player = get_player()
	if player != null and player.bubble != null:
		player.bubble.open_bubble_with_texture(texture)

func player_emote(emote: int): # 0: happy, 1: sad, 2: thinking, 3: success, 4: fail
	# decide the texture for the emote
	match emote:
		Emote.HAPPY:
			emote_with_texture(m_happy_texture)
		Emote.SAD:
			emote_with_texture(m_sad_texture)
		Emote.THINKING:
			emote_with_texture(m_thinking_texture)
		Emote.SUCCESS:
			emote_with_texture(m_success_texture)
		Emote.FAIL:
			emote_with_texture(m_fail_texture)
