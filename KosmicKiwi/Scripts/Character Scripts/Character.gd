extends KinematicBody2D

class_name Character

const PLAYER_PATH := "Player"

export var m_follow_distance := 1000.0
export var m_stop_distance := 700.0
export var m_speed := 500.0
export var m_detection_distance := 1800.0
export var m_timer_length := 6

enum CharacterState {FOLLOW, HOME, IDLE, STEAL}
export(CharacterState) var m_start_state = CharacterState.IDLE

var m_current_state
var m_player_node
var m_timer
var m_should_move := false
var m_home_pos
var m_active := true

func _ready():
	# get the player from the scene
	if (get_tree().get_nodes_in_group("level_root").size() > 0):
		var root = get_tree().get_nodes_in_group("level_root")[0]
		m_player_node = root.get_node("Actors").get_node("Player")
	if m_player_node == null:
		printerr("Character: Player node not found!")
	
	# setup a timer and connect it
	m_timer = Timer.new()
	m_timer.wait_time = m_timer_length
	m_timer.connect("timeout",self,"_on_Timer_timeout")
	add_child(m_timer)
	
	# get the m_home_pos global_position
	m_home_pos = $HomePosition.global_position
	
	# set the start_state
	set_state(m_start_state)

func _physics_process(delta):
	handle_state()


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
		_:
			set_state(CharacterState.HOME)

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
	var home_direction = m_home_pos - self.global_position
	move(home_direction)
	
	if (home_direction.length_squared() < (m_stop_distance * m_stop_distance)):
		set_state(CharacterState.IDLE)

func move(direction: Vector2) -> void:
	#var isometric_speed = IsometricVector.vector_to_isometric_vector(direction)
	var move_speed = direction.normalized() * m_speed
	move_and_slide(move_speed)

func _on_Timer_timeout():
	m_timer.stop()
	set_state(CharacterState.STEAL)
