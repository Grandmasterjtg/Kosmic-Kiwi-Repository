extends Friend

func _ready() -> void:
	self.friend_id = 0

func use_ability():
	if FriendManager.get_current_friend_id() == self.friend_id:
		print("Penguin ability used!")

func join_player():
	pass


