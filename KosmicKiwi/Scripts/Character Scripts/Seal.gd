extends Friend

func _ready() -> void:
	friend_id = 1

func _input(event):
	if event.is_action_pressed(FRIEND_ACTION):
			pass

func boulder_smash():
	pass

func meet_player():
	.meet_player()
	set_state(CharacterState.FOLLOW)
