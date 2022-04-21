extends RichTextLabel

const INTERACT_ACTION := "interact"
var m_should_update := true

func _ready():
	update_text()

func toggle_display() -> void:
	if m_should_update:
		visible = !visible

func set_display(should_display: bool) -> void:
	if m_should_update:
		update_text()
		visible = should_display

func set_should_update(should_update: bool) -> void:
	m_should_update = should_update

func update_text():
	if InputMap.get_action_list(INTERACT_ACTION).front() is InputEventKey:
		text = OS.get_scancode_string(InputMap.get_action_list(INTERACT_ACTION).front().scancode)
	elif InputMap.get_action_list(INTERACT_ACTION).front() is InputEventMouseButton:
		if InputMap.get_action_list(INTERACT_ACTION).front().button_index == BUTTON_LEFT:
			text = "Left Mouse"
		else:
			text = "Right Mouse"
