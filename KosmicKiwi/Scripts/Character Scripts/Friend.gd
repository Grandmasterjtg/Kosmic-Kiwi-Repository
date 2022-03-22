extends Character

var m_detection_area
var detected_bodies = []

func _ready():
	# get m_detection_area
	m_detection_area = .get_node("DetectionArea")
	if (m_detection_area == null):
		printerr("Failed to get m_detection_area: DetectionArea")
	
	# set starting state to FOLLOW
	.set_state(self.CharacterState.FOLLOW)

func _on_Button_pressed():
	if (!detected_bodies.empty()):
		for enemy in detected_bodies:
			if (enemy.is_in_group("Enemy")):
				print(enemy.name + " thinks your friend is stinky!")
				enemy.set_state(enemy.CharacterState.HOME)
	else:
		print("No enemies nearby.")

func _on_DetectionArea_body_entered(body: Node) -> void:
	detected_bodies.append(body)

func _on_DetectionArea_body_exited(body: Node) -> void:
	detected_bodies.erase(body)
