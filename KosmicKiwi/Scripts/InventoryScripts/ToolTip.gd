extends PanelContainer

# takes the name of an item
# sets up the tool tip display with the proper tool tip
func initialize_tip(item_name: String):
	var tool_tip = ItemData.get_tool_tip(item_name)
	var placeable = ItemData.is_placeable(item_name)
	var on_hotbar = InventoryData.get_is_interactable(ItemData.get_category(item_name))
	
	# null check for item validation
	if tool_tip != null and placeable != null:
		# add the name of the time to the display
		var text = "Name: " + item_name
		
		# add the tool tip to the display
		text += "\n\n" + tool_tip
		
		# add whether or not the item can be put onto the hotbar
		if on_hotbar:
			text += "\n\nHotbar Item: Yes"
		else:
			text += "\n\nHotbar Item: No"
		
		# add whether or not the item is placeable
		if placeable:
			text += "\n\nPlaceable: Yes"
		else:
			text += "\n\nPlaceable: No"
			
		$ToolTip.text = text
	
		if tool_tip.length() > 15:
			print("ToolTip: Big")
			$ToolTip.autowrap = true
			rect_size.x = 260
