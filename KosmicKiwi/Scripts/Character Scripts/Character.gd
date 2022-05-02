extends KinematicBody2D

class_name Character

const PLAYER_PATH := "Player"
const ANIMATION_IDLE_DOWN := "idle_front"
const ANIMATION_IDLE_LEFT := "idle_side"
const ANIMATION_IDLE_UP := "idle_back"

const ANIMATION_WALKING_DOWN := "walking_front"
const ANIMATION_WALKING_LEFT := "walking_side"
const ANIMATION_WALKING_UP := "walking_back"

export var m_follow_distance := 1000.0
export var m_stop_distance := 700.0
export var m_speed := 1400.0
export var m_detection_distance := 2200.0

enum CharacterState {FOLLOW, HOME, IDLE, STEAL}
export(CharacterState) var m_start_state = CharacterState.IDLE

onready var emote = $EmoteBubble
onready var animation = $AnimatedSprite
onready var transition_timer = $TransitionTimer
onready var stuck_timer = $StuckTimer

var m_current_state
var m_player_node
var m_should_move := false
var m_direction := Vector2(0, 1)
var m_home_pos : Vector2
var m_stuck := false

func _ready():
	# get the player from the scene
	if (get_tree().get_nodes_in_group("player").size() > 0):
		m_player_node = get_tree().get_nodes_in_group("player")[0]
#		print(name + " _ready(): " + m_player_node.name + " was found.")
	if m_player_node == null:
		printerr("Character: Player node not found!")
	
	# setup transition_timer and stuck_timer
	transition_timer.connect("timeout",self,"transition_to_idle")
	stuck_timer.connect("timeout",self,"teleport_home")
	
	# setup m_home_pos
	m_home_pos = global_position
	
	# set the start_state
	set_state(m_start_state)

func _physics_process(delta):
	handle_state()

func set_state(state):
	m_current_state = state
	if m_current_state == CharacterState.IDLE:
		change_idle_animation()
		stop_stuck_time()

func get_state() -> int:
	return m_current_state

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
	if (target != null):
		m_direction = target - self.global_position
		
		# maintain a certain distance, with a nice idle transition
		if (m_direction.length_squared() > (m_follow_distance * m_follow_distance)):
			move(m_direction)
			# check if too far for too long
			start_stuck_time()
		else:
			stop_stuck_time()
			if transition_timer.time_left <= 0:
				transition_timer.start()

func move_home():
	m_direction = m_home_pos - self.global_position
	move(m_direction)
	start_stuck_time()
	
	if (m_direction.length_squared() < (m_stop_distance * m_stop_distance)):
		stop_stuck_time()
		set_state(CharacterState.IDLE)

func move(direction: Vector2) -> void:
	var move_speed = direction.normalized() * m_speed
	move_and_slide(move_speed)
	change_walking_animation()

func change_idle_animation():
	if abs(m_direction.x + 0.1) > abs(m_direction.y):
		if m_direction.x > 0.1:
			animation.play(ANIMATION_IDLE_LEFT)
			animation.flip_h = true
		elif m_direction.x < -0.1:
			animation.play(ANIMATION_IDLE_LEFT)
			animation.flip_h = false
	elif abs(m_direction.x - 0.1) <= abs(m_direction.y):
		if m_direction.y < -0.1:
			animation.play(ANIMATION_IDLE_UP)
			animation.flip_h = false
		elif m_direction.y > 0.1:
			animation.play(ANIMATION_IDLE_DOWN)
			animation.flip_h = false

func change_walking_animation():
	if abs(m_direction.x + 0.1) > abs(m_direction.y):
		if m_direction.x > 0.1:
			animation.play(ANIMATION_WALKING_LEFT)
			animation.flip_h = true
		elif m_direction.x < -0.1:
			animation.play(ANIMATION_WALKING_LEFT)
			animation.flip_h = false
	elif abs(m_direction.x - 0.1) <= abs(m_direction.y):
		if m_direction.y < -0.1:
			animation.play(ANIMATION_WALKING_UP)
			animation.flip_h = false
		elif m_direction.y > 0.1:
			animation.play(ANIMATION_WALKING_DOWN)
			animation.flip_h = false

func teleport_home():
	# target_home changes to either player.global_pos or m_home_pos
	var target_home
	if m_current_state == CharacterState.FOLLOW and PlayerManager.get_player() != null:
		target_home = PlayerManager.get_player().global_position
	else:
		target_home = m_home_pos
		set_state(CharacterState.IDLE)
	
	global_position = target_home
	change_idle_animation()

func transition_to_idle():
	change_idle_animation()

func start_stuck_time():
	if !m_stuck:
		m_stuck = true
		stuck_timer.start()

func stop_stuck_time():
	if m_stuck:
		m_stuck = false
		stuck_timer.stop()
