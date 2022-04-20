extends Button

export var m_action_name = ""
var m_listening := false

func _input(event):
	if m_listening and action_exists(m_action_name):
		if event is InputEventKey or (event is InputEventMouseButton and \
		(event.button_index == BUTTON_LEFT or event.button_index == BUTTON_RIGHT)):
			InputMap.action_erase_events(m_action_name)
			InputMap.action_add_event(m_action_name, event)
			m_listening = false
			reset_button_text()

func _pressed():
	m_listening = true
	text = ""
	
func _ready():
	if !action_exists(m_action_name):
		print("Could not find action \"" + m_action_name + "\" in ChangeInputButton")
	else:
		reset_button_text()

func action_exists(var action_name : String) -> bool:
	return InputMap.get_actions().find(action_name) >= 0

func reset_button_text():
	if action_exists(m_action_name):
		if InputMap.get_action_list(m_action_name).front() is InputEventKey:
			text = OS.get_scancode_string(InputMap.get_action_list(m_action_name).front().scancode)
		elif InputMap.get_action_list(m_action_name).front() is InputEventMouseButton:
			if InputMap.get_action_list(m_action_name).front().button_index == BUTTON_LEFT:
				text = "Left Mouse"
			else:
				text = "Right Mouse"
