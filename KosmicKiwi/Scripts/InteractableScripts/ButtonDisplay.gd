extends RichTextLabel

var m_should_update := true

func toggle_display() -> void:
	if m_should_update:
		visible = !visible

func set_display(should_display: bool) -> void:
	if m_should_update:
		visible = should_display

func set_should_update(should_update: bool) -> void:
	m_should_update = should_update
