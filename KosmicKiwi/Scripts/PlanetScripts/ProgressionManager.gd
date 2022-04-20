extends Node

enum FriendID {PENGUIN, SEAL, STINKY}

var found_penguin := false		#0
var found_seal := false			#1
var found_stinky := false		#2

var joined_penguin := false		#0
var joined_seal := false		#1
var joined_stinky := false		#2

const penguin_found_dialog = "Find_Penguin"
const seal_found_dialog = "Find_Seal"
const stinky_found_dialog = "Find_Stinky"

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

func find_friend(friend_id: int):
	match friend_id:
		FriendID.PENGUIN:
			if !found_penguin:
				found_penguin = true
				var dialog = Dialogic.start(penguin_found_dialog)
				add_child(dialog)
		FriendID.SEAL:
			if !found_seal:
				found_seal = true
				var dialog = Dialogic.start(seal_found_dialog)
				add_child(dialog)
		FriendID.STINKY:
			if !found_stinky:
				found_stinky = true
				var dialog = Dialogic.start(stinky_found_dialog)
				add_child(dialog)

func join_friend(friend_id: int):
	match friend_id:
		FriendID.PENGUIN:
			joined_penguin = true
		FriendID.SEAL:
			joined_seal = true
		FriendID.STINKY:
			joined_stinky = true

