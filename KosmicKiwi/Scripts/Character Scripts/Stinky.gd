extends Friend

func _ready() -> void:
	self.friend_id = 2

func use_ability():
	if FriendManager.get_current_friend_id() == self.friend_id:
		print("Stinky ability used!")
		if (!m_detected_bodies.empty()):
			for body in m_detected_bodies:
				if (body.is_in_group("enemy")):
					print(body.name + " thinks your friend is stinky!")
					body.stink_detected()
		else:
			print("No enemies nearby.")

func meet_player():
	.meet_player()
	set_state(CharacterState.FOLLOW)
