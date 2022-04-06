extends Node2D

signal interacted
signal timeout

# collection variables
export var m_name : String = "Metal Deposit"
var m_item_name : String= "Metal"
var m_item_quantity := 1
var m_required_tool = null

# interactable area
onready var m_interactable = $Interactable
onready var m_button = $ButtonDisplay

# interaction variables
var m_in_area := false
const INTERACT := "interact"

# cooldown variables
var m_in_cooldown := false
var m_cooldown_time : float = 1.0
onready var m_timer := $CooldownTimer

func _ready() -> void:
	# resource setup
	var resource_data = ResourceData.get_resource_data(m_name)
	m_item_name = resource_data["ItemName"]
	m_item_quantity = resource_data["Quantity"]
	m_cooldown_time = resource_data["Cooldown"]
	m_required_tool = resource_data["RequiredTool"]
	
	# timer setup
	m_timer.wait_time = (m_cooldown_time)
	
	# singal setup
	m_timer.connect("timeout", self, "_on_timeout")
	m_interactable.connect("interacted", self, "_on_interact")
	m_interactable.connect("entered", m_button, "set_display", [true])
	m_interactable.connect("exited", m_button, "set_display", [false])
	
func _on_timeout() -> void:
	# no longer in cooldown
	m_in_cooldown = false
	emit_signal("timeout")
	
	# the button can now change display
	m_button.set_should_update(true)
	# if the player is still within the area set button display to true
	if m_interactable.is_in_area():
		m_button.set_display(true)
	
func _on_interact() -> void:
	if !m_in_cooldown:
		#Inventory.add_item(m_item_name, m_item_quantity)
		emit_signal("interacted")
		# starts the cooldown timer
		m_timer.start()
		m_in_cooldown = true
		
		# modify button display
		m_button.set_display(false)
		m_button.set_should_update(false)
