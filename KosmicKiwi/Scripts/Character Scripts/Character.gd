extends KinematicBody2D

class_name Character

const PLAYER_PATH := "Player"

export var m_follow_distance := 1000.0
export var m_stop_distance := 700.0
export var m_speed := 1500.0
export var m_detection_distance := 2000.0

enum CharacterState {FOLLOW, HOME, IDLE, STEAL}
export(CharacterState) var m_start_state = CharacterState.IDLE

onready var m_home_pos = $HomePosition.global_position
onready var emote = $EmoteBubble

var m_current_state
var m_player_node
var m_should_move := false
var m_active := true

func _ready():
	# get the player from the scene
	if (get_tree().get_nodes_in_group("player").size() > 0):
#		var root = get_tree().get_nodes_in_group("level_root")[0]
		m_player_node = get_tree().get_nodes_in_group("player")[0]
		print(name + " _ready(): " + m_player_node.name + " was found.")
	if m_player_node == null:
		printerr("Character: Player node not found!")
	
	# set the start_state
	set_state(m_start_state)

func _physics_process(delta):
	handle_state()

func set_state(state):
	m_current_state = state

func handle_state():
	match m_current_state:
		CharacterState.FOLLOW:
			if (m_player_node != null):
				follow_target(m_player_node.global_position)
			else:
				printerr(name + " handle_state(): player was null!")
				set_state(CharacterState.IDLE)
		CharacterState.HOME:
			move_home()
		CharacterState.IDLE:
			pass
		_:
			set_state(CharacterState.HOME)

# follows a global_position target
func follow_target(target):
	print(name + " follow_target(player) called.")
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


