extends TextureRect

var m_item_name : String
var m_item_quantity : int

# takes the name of an item and the amount of that item
# sets the item UI to display that item with the given amount
func set_item(item_name: String, item_quantity: int) -> void:
	# set name and amount
	m_item_name = item_name
	m_item_quantity = item_quantity
	
	# change the texture
	texture = load("res://ArtAssets/Temp/" + item_name + ".png")
	
	var stack_size = ItemData.get_item(item_name)["StackSize"]
	if stack_size == 1:
		$Count.visible = false
	else:
		$Count.visible = true
		$Count.text = String(item_quantity)
	
