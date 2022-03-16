extends TextureRect

var m_item_name : String
var m_item_quantity : int

func _ready():
	if randi() % 2 == 0:
		m_item_name = "Iron Sword"
	else:
		m_item_name = "Tree Branch"
	
	texture = load("res://ArtAssets/Temp/" + m_item_name + ".png")
	
	var stack_size = int(ItemData.m_item_data[m_item_name]["StackSize"])
	m_item_quantity = randi() % stack_size + 1
	
	if stack_size == 1:
		$Count.visible = false
	else:
		$Count.text = String(m_item_quantity)
