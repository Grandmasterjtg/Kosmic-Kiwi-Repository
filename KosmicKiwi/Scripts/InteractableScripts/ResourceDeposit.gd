extends Sprite

# collection variables
export var m_name : String = "Metal Deposit"
var m_item_name : String= "Metal"
var m_item_quantity := 1
var m_required_tool = null

# interactable area
onready var interactable = $Interactable

# interaction variables
var m_in_area := false
const INTERACT := "interact"

# cooldown variables
var m_in_cooldown := false
export var m_cooldown_time : float = 1.0
onready var m_timer := $CooldownTimer

func _ready() -> void:
	# resource setup
	var resource_data = ResourceData.get_resource_data(m_name)
	m_item_name = resource_data["ItemName"]
	m_item_quantity = resource_data["Quantity"]
	m_required_tool = resource_data["RequiredTool"]
	
	# timer setup
	m_timer.wait_time = (m_cooldown_time)
	
	# singal setup
	m_timer.connect("timeout", self, "_on_timeout")
	interactable.connect("interacted", self, "_on_interact")
	interactable.connect("entered", $ButtonDisplay, "toggle_display")
	interactable.connect("exited", $ButtonDisplay, "toggle_display")
	
func _on_timeout() -> void:
	m_in_cooldown = false
	self.rotation_degrees = 0
	
func _on_interact() -> void:
	if !m_in_cooldown:
		Inventory.add_item(m_item_name, m_item_quantity)
		# starts the cooldown timer
		m_timer.start()
		m_in_cooldown = true
		self.rotation_degrees = 180
