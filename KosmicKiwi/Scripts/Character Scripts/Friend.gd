extends Character

class_name Friend

# components
var m_detection_area

# variables
var m_detected_bodies = []

func _ready():
	# connect to DetectionArea
	m_detection_area = $DetectionArea
	if (m_detection_area != null):
		m_detection_area.connect("body_entered",self,"_on_DetectionArea_body_entered")
		m_detection_area.connect("body_exited",self,"_on_DetectionArea_body_exited")
	
	# set starting state to FOLLOW
	.set_state(self.CharacterState.FOLLOW)

func _on_DetectionArea_body_entered(body: Node) -> void:
	m_detected_bodies.append(body)

func _on_DetectionArea_body_exited(body: Node) -> void:
	m_detected_bodies.erase(body)
