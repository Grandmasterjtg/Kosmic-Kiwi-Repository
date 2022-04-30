extends Character

class_name Friend

const FRIEND_ACTION = "friend"
onready var m_detection_area = $DetectionArea
onready var m_interact_area = $InteractArea

var friend_id := 0
var m_detected_bodies = []
var m_active_friend := false

func _ready():
	# connect to DetectionArea
	if (m_detection_area != null):
		m_detection_area.connect("body_entered",self,"_on_DetectionArea_body_entered")
		m_detection_area.connect("body_exited",self,"_on_DetectionArea_body_exited")
	
	# connect to InteractArea
	if m_interact_area != null:
		m_interact_area.connect("body_entered",self,"_on_InteractArea_body_entered")

func _input(event):
	if event.is_action_pressed(FRIEND_ACTION):
			use_ability()

func _on_DetectionArea_body_entered(body: Node) -> void:
	m_detected_bodies.append(body)
#	print(body.name + " entered.")
	if (body.is_in_group("player") and !FriendManager.check_friend_found(friend_id)):
		meet_player()

func _on_DetectionArea_body_exited(body: Node) -> void:
	m_detected_bodies.erase(body)

func _on_InteractArea_body_entered(body: Node) -> void:
	if stuck_timer.time_left <= 0:
		if body.is_in_group("player"):
			if !FriendManager.check_friend_joined(friend_id):
				join_crew()
			else:
				FriendManager.switch_friend(friend_id)

func meet_player():
	if !FriendManager.check_friend_found(friend_id):
			FriendManager.find_friend(friend_id)

func join_crew():
	print(name + " has joined your crew!")
	FriendManager.join_friend(friend_id)

func use_ability():
	pass

func set_friend_active(state: bool):
	if state:
		m_active_friend = true
		.set_state(CharacterState.FOLLOW)
	else:
		m_active_friend = false
		.set_state(CharacterState.HOME)
		stuck_timer.start()

func get_friend_active() -> bool:
	return m_active_friend

func set_home_position(position: Vector2):
	m_home_pos = position

func get_home_position() -> Vector2:
	return m_home_pos
