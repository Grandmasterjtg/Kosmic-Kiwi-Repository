extends Node

const m_neutral_texture = preload("res://ArtAssets/Characters/emotes/kiwineutral.png")
const m_happy_texture = preload("res://ArtAssets/Characters/emotes/kiwihappy.png")
const m_sad_texture = preload("res://ArtAssets/Characters/emotes/kiwisad.png")
const m_thinking_texture = preload("res://ArtAssets/Characters/emotes/kiwi thinking.png")

var tutorial_index := -1
var tutorial_gathering_done := false
var tutorial_crafting_done := false
var tutorial_gadget_done := false
var tutorial_friend_done := false

enum Emote {NEUTRAL, HAPPY, SAD, THINKING}

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

func player_emote(emote: int):
	# decide the texture for the emote
	match emote:
		Emote.NEUTRAL:
			emote_with_texture(m_neutral_texture)
		Emote.HAPPY:
			emote_with_texture(m_happy_texture)
		Emote.SAD:
			emote_with_texture(m_sad_texture)
		Emote.THINKING:
			emote_with_texture(m_thinking_texture)
