extends KinematicBody2D

class_name Character

const PLAYER_PATH := "Player"

export var m_follow_distance := 200
export var m_stop_distance := 100
export var m_speed := 200.0
export var m_timer_length := 3

enum CharacterState {FOLLOW, HOME, IDLE, STEAL}

var m_player_node
var m_timer
var m_current_state
var m_should_move := false
var m_start_pos

func _ready():
	# get the player from the scene
	m_player_node = get_parent().get_node(PLAYER_PATH)
	
	# setup a timer and connect it
	m_timer = Timer.new()
	m_timer.wait_time = m_timer_length
	m_timer.connect("timeout",self,"_on_Timer_timeout")
	add_child(m_timer)
	
	# get the starting global_position
	m_start_pos = self.global_position

func _physics_process(delta):
	handle_state()


func set_state(state):
	m_current_state = state
	match state:
		CharacterState.FOLLOW:
			pass
		CharacterState.HOME:
			pass
		CharacterState.IDLE:
			m_timer.start()
		CharacterState.STEAL:
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

# follows a global_position target
func follow_target(target):
	if (target != null):
		var target_direction = target - self.global_position
		
		if (target_direction.length_squared() > (m_follow_distance * m_follow_distance)):
			m_should_move = true
		elif (target_direction.length_squared() < (m_stop_distance * m_stop_distance)):
			m_should_move = false
			
		if (m_should_move):
			#look_at(target)
			move(target_direction)

func move_home():
	var home_direction = m_start_pos - self.global_position
	#look_at(m_start_pos)
	move(home_direction)
	
	if (home_direction.length_squared() < (m_stop_distance * m_stop_distance)):
		set_state(CharacterState.IDLE)

func steal_from_player():
	var player_direction = m_player_node.global_position - self.global_position
	#look_at(player_direction)
	move(player_direction)
	
	if (player_direction.length_squared() < (m_stop_distance * m_stop_distance)):
		print("Something was stolen!")
		set_state(CharacterState.HOME)

func move(direction: Vector2) -> void:
	# var isometric_speed = IsometricVector.vector_to_isometric_vectyor(dirction)
	var move_speed = direction.normalized() * m_speed
	move_and_slide(move_speed)

func _on_Timer_timeout():
	m_timer.stop()
	set_state(CharacterState.STEAL)
