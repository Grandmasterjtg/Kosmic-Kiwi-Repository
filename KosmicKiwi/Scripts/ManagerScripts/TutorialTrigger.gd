extends Area2D

const TUTORIAL = "Friend"

func _ready() -> void:
	connect("body_entered",self,"trigger_dialog")

func trigger_dialog(body):
	if FriendManager.check_friend_joined(FriendManager.FriendID.PENGUIN):
		DialogManager.play_dialog(TUTORIAL)
