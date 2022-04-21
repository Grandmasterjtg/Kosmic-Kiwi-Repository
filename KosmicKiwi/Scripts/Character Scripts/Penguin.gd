extends Friend

func _ready() -> void:
	self.friend_id = 0

func use_ability():
	print("Penguin ability used!")

func meet_player():
	.meet_player()
	.set_state(self.CharacterState.FOLLOW)
