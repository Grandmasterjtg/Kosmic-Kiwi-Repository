extends Node2D

signal interacted
signal timeout
signal destroy

var m_should_destroy = false

# collection variables
export var m_name : String = "Metal Deposit"
var m_item_name : String = "Metal"
var m_item_quantity := 1
var m_required_tool = null
var m_once := false

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

var m_id : Vector2

func _ready() -> void:
	# set up the internal variables for the funcionality 
	# of the resource deposit with information form
	# the ResourceData script
	var resource_data = ResourceData.get_resource_data(m_name)
	m_item_name = ResourceData.get_item_name(m_name)
	m_item_quantity = ResourceData.get_quantity(m_name)
	m_cooldown_time = ResourceData.get_cooldown(m_name)
	m_required_tool = ResourceData.get_tool(m_name)
	m_once = ResourceData.is_one_time(m_name)
	
	# timer setup
	m_timer.wait_time = (m_cooldown_time)
	
	# singal setup
	m_timer.connect("timeout", self, "_on_timeout")
	m_interactable.connect("interacted", self, "_on_interact")
	m_interactable.connect("entered", m_button, "set_display", [true])
	m_interactable.connect("exited", m_button, "set_display", [false])
	
#	# add resource to resource manager if it is a one time use
#	if m_once:
#		m_id = self.get_global_position()
#		ResourceManager.add_resource(m_id)
#		if ResourceManager.check_resource_destroyed(m_id):
#			m_should_destroy = true
			
func _process(delta):
	# if the resource have previousely been destroyed
	if m_should_destroy:
		emit_signal("destroy")
	
	
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
	# show the required tool bubble
	if !m_in_cooldown and m_required_tool != null:
		PlayerManager.emote_with_texture(load("res://ArtAssets/ItemIcons/" + m_required_tool + ".png"))
	
	# if the player interacts with the deposit with all requirments met
	if !m_in_cooldown and (!m_required_tool or Inventory.check_selected_item(m_required_tool)):
		# add the deposit's item to the inventory
		Inventory.add_item(m_item_name, m_item_quantity)
		emit_signal("interacted")
		
		# if the resource depsoit is a one time use
		if m_once:
			ResourceManager.set_resource_destroyed(m_id, true)
			emit_signal("destroy")
		# set respawn and animations
		else:
			# starts the cooldown timer
			m_timer.start()
			m_in_cooldown = true
			
			# modify interact button display
			m_button.set_display(false)
			m_button.set_should_update(false)
			
			# if the depsoit required a tool, remove it form the inventory
			if m_required_tool:
				Inventory.remove_item(m_required_tool)
