extends Friend

func _ready() -> void:
	friend_id = 1

func use_ability():
	if FriendManager.get_current_friend_id() == self.friend_id:
		print("Seal ability used!")

func meet_player():
	.meet_player()
	set_state(CharacterState.FOLLOW)
