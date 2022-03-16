extends Control

const ITEM_CLASS = preload("res://Scenes/UI/Inventory/ItemUI.tscn")
var item = null
		
func _process(delta):
	if Input.is_action_just_pressed("move_down"):
		# intantiate the item class
		item = ITEM_CLASS.instance()
		add_child(item)

func _gui_input(event):
	if event.is_action_pressed("Press") and event.button_index == BUTTON_LEFT:
		$Panel.visible = !$Panel.visible
