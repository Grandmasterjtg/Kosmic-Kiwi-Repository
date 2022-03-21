extends KinematicBody2D

const PLAYER_PATH := "Player"

export var m_follow_distance := 200
export var m_stop_distance := 100

var m_speed := 200.0
enum EnemyState {CHASE, HOME}

var should_move := false
var followed_recently := false
var m_player_target
var m_timer
var m_current_state

var m_start_pos

func _ready():
	m_player_target = get_parent().get_node(PLAYER_PATH)
	m_timer = get_node("Timer")
	m_start_pos = self.global_position

func _physics_process(delta):
	match m_current_state:
		EnemyState.CHASE:
			follow_target(m_player_target.global_position)
		EnemyState.HOME:
			followed_recently = true
			m_timer.start()
		
	if (!followed_recently):
		follow_target(m_player_target.global_position)
	else:
		move_home()

func follow_target(target):
	if (target != null):
		var target_direction = target - self.global_position
		
		if (target_direction.length_squared() > (m_follow_distance * m_follow_distance)):
			should_move = true
		elif (target_direction.length_squared() < (m_stop_distance * m_stop_distance)):
			should_move = false
			set_state(EnemyState.HOME)
			
		if (should_move):
			look_at(target)
			
			var move_speed = target_direction.normalized() * m_speed
			move_and_slide(move_speed, Vector2.UP)
			
func move_home():
	var home_direction = m_start_pos - self.global_position
	look_at(m_start_pos)
	move_and_slide(home_direction, Vector2.UP)

func set_state(state):
	m_current_state = state
	handle_state()

func handle_state():
	match m_current_state:
		EnemyState.CHASE:
			pass
		EnemyState.HOME:
			followed_recently = true
			m_timer.start()
		_:
			print("defaultState Handled")

func _on_Timer_timeout():
	set_state(EnemyState.CHASE)
