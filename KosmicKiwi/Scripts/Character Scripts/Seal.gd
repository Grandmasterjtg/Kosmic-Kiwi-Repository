extends Friend

const FRIEND := "friend"

func _process(delta):
	if Input.is_action_just_pressed(FRIEND):
		print("Being stinky...")
		be_stinky()

func be_stinky():
	if (!m_detected_bodies.empty()):
		for body in m_detected_bodies:
			if (body.is_in_group("Enemy")):
				print(body.name + " thinks your friend is stinky!")
				body.set_state(body.CharacterState.HOME)
	else:
		print("No enemies nearby.")
