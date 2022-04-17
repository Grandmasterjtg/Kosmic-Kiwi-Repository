extends PanelContainer


func initialize_tip(item_name: String):
	var text = ItemData.get_tool_tip(item_name)
	if text != null:
		$ToolTip.text = text
	
	print($ToolTip.get_total_character_count())
	if $ToolTip.get_total_character_count() > 15:
		$ToolTip.autowrap = true
		rect_size.x = 280
