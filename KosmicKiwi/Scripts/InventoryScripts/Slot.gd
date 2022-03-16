extends Control

var ItemClass = preload("res://Scenes/UI/Inventory/ItemUI.tscn")
var item = null
		
func _process(delta):
	if Input.is_action_just_pressed("move_down"):
		# intantiate the item class
		item = ItemClass.instance()
		add_child(item)
		
		# set the size of the item's texture rect
		item.rect_min_size = Vector2(rect_size.x - 10, rect_size.y - 10)
		item.expand = true
		item.rect_size = item.rect_min_size
		
		# center position in slot
		var x = rect_size.x/2 - item.rect_size.x/2
		var y = rect_size.y/2 - item.rect_size.y/2
		item.rect_position = Vector2(x,y)
