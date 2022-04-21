extends Friend

func _ready() -> void:
	friend_id = 2

func _input(event):
	if event.is_action_pressed(FRIEND_ACTION):
			be_stinky()

func be_stinky():
	if (!m_detected_bodies.empty()):
		for body in m_detected_bodies:
			if (body.is_in_group("Enemy")):
				print(body.name + " thinks your friend is stinky!")
				body.stink_detected()
	else:
		print("No enemies nearby.")

func meet_player():
	.meet_player()
	set_state(CharacterState.FOLLOW)
