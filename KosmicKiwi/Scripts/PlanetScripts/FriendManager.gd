extends Node

enum FriendID {PENGUIN, SEAL, STINKY}

var found_penguin := false		#0
var found_seal := false			#1
var found_stinky := false		#2

var joined_penguin := false		#0
var joined_seal := false		#1
var joined_stinky := false		#2

const penguin_found_dialog = "Find_Penguin"
const stinky_found_dialog = "Find_Stinky"
const seal_found_dialog = "Find_Seal"
const penguin_image = preload("res://ArtAssets/Characters/emotes/penguinhappy.png")
const stinky_image = preload("res://ArtAssets/Characters/emotes/friendthinking.png")
const seal_image = preload("res://ArtAssets/Characters/emotes/sealthinking.png")

var m_current_friend_id = -1
var m_dialog_disabled := false

func check_friend_found(friend_id: int) -> bool:
	match friend_id:
		FriendID.PENGUIN:
			return found_penguin
		FriendID.SEAL:
			return found_seal
		FriendID.STINKY:
			return found_stinky
		_: return false

func check_friend_joined(friend_id: int) -> bool:
	match friend_id:
		FriendID.PENGUIN:
			return joined_penguin
		FriendID.SEAL:
			return joined_seal
		FriendID.STINKY:
			return joined_stinky
		_: return false

func set_current_friend_id(id: int):
	m_current_friend_id = id

func get_current_friend_id() -> int:
	return m_current_friend_id

func get_current_friend_node() -> KinematicBody2D:
	var friend
	match m_current_friend_id:
		FriendID.PENGUIN:
			if !get_tree().get_nodes_in_group("penguin").empty():
				friend = get_tree().get_nodes_in_group("penguin")[0]
		FriendID.SEAL:
			if !get_tree().get_nodes_in_group("seal").empty():
				friend = get_tree().get_nodes_in_group("seal")[0]
		FriendID.STINKY:
			if !get_tree().get_nodes_in_group("stinky").empty():
				friend = get_tree().get_nodes_in_group("stinky")[0]
#	if friend != null: print(friend.name)
	return friend

func find_friend(friend_id: int):
	match friend_id:
		FriendID.PENGUIN:
			if !found_penguin:
				found_penguin = true
				if !m_dialog_disabled:
					var dialog = Dialogic.start(penguin_found_dialog)
					get_tree().get_nodes_in_group("canvas")[0].add_child(dialog)
		FriendID.SEAL:
			if !found_seal:
				found_seal = true
				if !m_dialog_disabled:
					var dialog = Dialogic.start(seal_found_dialog)
					get_tree().get_nodes_in_group("canvas")[0].add_child(dialog)
		FriendID.STINKY:
			if !found_stinky:
				found_stinky = true
				if !m_dialog_disabled:
					var dialog = Dialogic.start(stinky_found_dialog)
					get_tree().get_nodes_in_group("canvas")[0].add_child(dialog)

func join_friend(friend_id: int):
	match friend_id:
		FriendID.PENGUIN:
			joined_penguin = true
		FriendID.SEAL:
			joined_seal = true
		FriendID.STINKY:
			joined_stinky = true
	switch_friend(friend_id)

func switch_friend(friend_id: int):
	# check current friend base case
	if m_current_friend_id < 0:
		m_current_friend_id = friend_id
		current_friend_follow_player()
		update_friend_display()

	if m_current_friend_id == friend_id:
		pass
	else:
		# home old friend and start their StuckTimer
		var friend = get_current_friend_node()
		if friend != null:
#			print("Setting HOME state and starting StuckTimer")
			friend.set_state(friend.CharacterState.HOME)
			friend.get_node("StuckTimer").start()
		
		# set new m_current_friend_id, set to follow, update_friend_ability
		m_current_friend_id = friend_id
		current_friend_follow_player()
		update_friend_display()

func current_friend_follow_player():
#	print("Calling current_friend_follow_player")
	if m_current_friend_id == null:
		return

	var friend = get_current_friend_node()
	if friend != null:
		friend.set_state(friend.CharacterState.FOLLOW)

func update_friend_display():
	# this will change the UI images and mouse texture
	var friend_display = get_tree().get_nodes_in_group("canvas")[0].get_node("FriendDisplay")
	if friend_display != null:
		match m_current_friend_id:
			FriendID.PENGUIN:
				friend_display.set_texture(penguin_image)
			FriendID.STINKY:
				friend_display.set_texture(stinky_image)
			FriendID.SEAL:
				friend_display.set_texture(seal_image)
