extends TextureRect

const FILE_PATH = "res://ArtAssets/ItemIcons/"
const FILE_TYPE = ".png"

const TOOL_TIP_CLASS = preload("res://Scenes/UI/Inventory/ToolTip.tscn")

var m_item_name : String
var m_item_quantity : int


func _ready():
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")

# takes the name of an item and the amount of that item
# sets the item UI to display the given item with the given amount
func set_item(item_name: String, item_quantity: int) -> void:
	# set name and amount
	m_item_name = item_name
	m_item_quantity = item_quantity
	
	# change the texture
	texture = load(FILE_PATH + item_name + FILE_TYPE)
	
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
	
func _on_mouse_entered():
	var tool_tip = TOOL_TIP_CLASS.instance()
	tool_tip.initialize_tip(m_item_name)
	MouseManager.set_mouse_object(tool_tip)
	
func _on_mouse_exited():
	MouseManager.reset_mouse_texture()
