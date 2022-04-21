extends Character

class_name Friend

const FRIEND_ACTION = "friend"
var friend_id := 0

onready var m_detection_area = $DetectionArea
var m_detected_bodies = []

func _ready():
	# connect to DetectionArea
	if (m_detection_area != null):
		m_detection_area.connect("body_entered",self,"_on_DetectionArea_body_entered")
		m_detection_area.connect("body_exited",self,"_on_DetectionArea_body_exited")

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
