extends TextureRect

const FOLDER_PATH = "res://ArtAssets/Temp/"

var m_item_name : String
var m_item_quantity : int

# takes the name of an item and the amount of that item
# sets the item UI to display the given item with the given amount
func set_item(item_name: String, item_quantity: int) -> void:
	# set name and amount
	m_item_name = item_name
	m_item_quantity = item_quantity
	
	# change the texture
	texture = load(FOLDER_PATH + item_name + ".png")
	
	var stack_size = ItemData.get_stack_size(item_name)
	if stack_size == 1:
		$Count.visible = false
	else:
		$Count.visible = true
		$Count.text = String(item_quantity)
		
func get_item_name() -> String:
	return m_item_name

func get_item_category() -> String:
	return ItemData.get_category(m_item_name)
	
