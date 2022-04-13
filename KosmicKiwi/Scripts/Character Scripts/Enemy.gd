extends Character

const TARGET_ITEM = "Fiber"

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
				Inventory.remove_item(TARGET_ITEM)
				set_state(CharacterState.HOME)
