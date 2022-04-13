extends Label


func initialize_tip(item_name: String):
	var text = ItemData.get_tool_tip(item_name)
	if text != null:
		self.text = text
