extends Character

const TARGET_ITEM = "Fiber"
var stinky_texture = load("res://ArtAssets/Characters/friend.png")
var item_texture = load("res://ArtAssets/ItemIcons/Fiber.png")

export var m_timer_length := 5
var m_timer

func _ready():
	# setup a timer and connect it
	m_timer = Timer.new()
	m_timer.one_shot = true
	m_timer.wait_time = m_timer_length
	m_timer.connect("timeout",self,"_on_Timer_timeout")
	.add_child(m_timer)

func set_state(state):
	m_current_state = state
	match state:
		CharacterState.IDLE:
			m_timer.start()
		_:
			pass

func handle_state():
	match m_current_state:
		CharacterState.FOLLOW:
			if (m_timer.time_left > 0):
				pass
			else:
				follow_target(m_player_node.global_position)
		CharacterState.HOME:
			move_home()
		CharacterState.IDLE:
			pass
		CharacterState.STEAL:
			if (m_timer.time_left > 0):
				pass
			else:
				steal_from_player()
		_:
			set_state(CharacterState.HOME)

func steal_from_player():
	if (Inventory.item_exists_in_inventory(TARGET_ITEM)):
		if (self.global_position.distance_to(m_player_node.global_position) < m_detection_distance):
			var player_direction = m_player_node.global_position - self.global_position
			move(player_direction)
			
			if (player_direction.length_squared() < (m_stop_distance * m_stop_distance)):
				scale += Vector2(0.1,0.1)
				emote.open_bubble_with_texture(item_texture)
				Inventory.remove_item(TARGET_ITEM)
				set_state(CharacterState.HOME)

func stink_detected():
	set_state(CharacterState.HOME)
	emote.open_bubble_with_texture(stinky_texture)

func _on_Timer_timeout():
	set_state(CharacterState.STEAL)
