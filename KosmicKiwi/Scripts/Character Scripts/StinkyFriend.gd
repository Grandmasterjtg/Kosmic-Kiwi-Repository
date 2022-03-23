extends Friend

func _ready():
	# connect to button
	var button = get_node("Button")
	if (button != null):
		button.connect("pressed",self,"_on_Button_pressed")
	
	# set starting state to FOLLOW
	.set_state(self.CharacterState.FOLLOW)

func _on_Button_pressed():
	if (!m_detected_bodies.empty()):
		for body in m_detected_bodies:
			if (body.is_in_group("Enemy")):
				print(body.name + " thinks your friend is stinky!")
				body.set_state(body.CharacterState.HOME)
	else:
		print("No enemies nearby.")
