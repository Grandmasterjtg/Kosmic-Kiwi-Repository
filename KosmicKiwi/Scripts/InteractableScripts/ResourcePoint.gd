extends Sprite

onready var collection_area := $CollectionArea
onready var button_display := $ButtonDisplay

# collection variables
export var m_name = "Tree Branch Deposit"
var m_item_name := "Tree Branch"
var m_item_quantity := 1
var m_required_tool = null


# interaction variables
var m_in_area := false
const INTERACT := "interact"

# cooldown variables
var m_in_cooldown := false
onready var m_timer := $CooldownTimer

func _ready():
	# resource setup
	var resource_data = ResourceData.get_resource_data(m_name)
	m_item_name = resource_data["ItemName"]
	m_item_quantity = resource_data["Quantity"]
	
	# signal setup
	collection_area.connect("body_entered", self, "_on_body_entered")
	collection_area.connect("body_exited", self, "_on_body_exited")
	m_timer.connect("timeout", self, "_on_timeout")
	
func _process(delta):
	# add the resources item to the inventory if the player interacts with it
	if m_in_area and !m_in_cooldown and Input.is_action_just_pressed(INTERACT):
		Inventory.add_item(m_item_name, m_item_quantity)
		# starts the cooldown timer
		m_timer.start()
		m_in_cooldown = true
		self.rotation_degrees = 180
	
func _on_body_entered(body) -> void:
	button_display.visible = true
	m_in_area = true
	
func _on_body_exited(body) -> void:
	button_display.visible = false
	m_in_area = false
	
func _on_timeout() -> void:
	m_in_cooldown = false
	self.rotation_degrees = 0
