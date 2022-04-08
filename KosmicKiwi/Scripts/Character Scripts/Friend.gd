extends Character

class_name Friend

const action = "friend"

var m_detection_area
var m_detected_bodies = []

func _ready():
	# connect to DetectionArea
	m_detection_area = $DetectionArea
	if (m_detection_area != null):
		m_detection_area.connect("body_entered",self,"_on_DetectionArea_body_entered")
		m_detection_area.connect("body_exited",self,"_on_DetectionArea_body_exited")

func _input(event):
	if event.is_action_pressed(action):
			be_stinky()

func _on_DetectionArea_body_entered(body: Node) -> void:
	m_detected_bodies.append(body)
	print(body.name + " entered.")

func _on_DetectionArea_body_exited(body: Node) -> void:
	m_detected_bodies.erase(body)
	print(body.name + " left.")

func be_stinky():
	print("stinky time.")
	for enemy in m_detected_bodies:
		if enemy.is_in_group("Enemy"):
			enemy.set_state(enemy.CharacterState.HOME)
