extends Character

class_name Friend

const FRIEND_ACTION = "friend"
onready var m_detection_area = $DetectionArea

var friend_id := 0
var m_detected_bodies = []
var m_active_friend := false

func _ready():
	# connect to DetectionArea
	if (m_detection_area != null):
		m_detection_area.connect("body_entered",self,"_on_DetectionArea_body_entered")
		m_detection_area.connect("body_exited",self,"_on_DetectionArea_body_exited")

func _input(event):
	if event.is_action_pressed(self.FRIEND_ACTION):
			use_ability()

func _on_DetectionArea_body_entered(body: Node) -> void:
	m_detected_bodies.append(body)
#	print(body.name + " entered.")
	if (body.is_in_group("player") and !ProgressionManager.check_friend_found(friend_id)):
		meet_player()

func _on_DetectionArea_body_exited(body: Node) -> void:
	m_detected_bodies.erase(body)

func meet_player():
	if !ProgressionManager.check_friend_found(friend_id):
			ProgressionManager.find_friend(friend_id)

func use_ability():
	pass

func set_friend_active(state: bool):
	if state:
		m_active_friend = true
		.set_state(self.CharacterState.FOLLOW)
	else:
		m_active_friend = false
		.set_state(self.CharacterState.HOME)

func get_friend_active() -> bool:
	return m_active_friend


