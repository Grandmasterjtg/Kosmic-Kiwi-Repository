extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# export var m_speed := 100.0
const PLAYER_PATH := "Player"

export var m_follow_distance := 200
export var m_stop_distance := 100
var should_move := false
var m_target

func _ready():
	m_target = get_parent().get_node(PLAYER_PATH)

func _physics_process(delta):
	if (m_target != null):
		var target_direction = m_target.global_position - global_position
		
		if (target_direction.length_squared() > (m_follow_distance * m_follow_distance)):
			should_move = true
		elif (target_direction.length_squared() < (m_stop_distance * m_stop_distance)):
			should_move = false
			
		if (should_move):
			look_at(m_target.position)
			move_and_slide(target_direction, Vector2.UP)
