extends KinematicBody2D

const ACTION_DOWN := "move_down"
const ACTION_LEFT := "move_left"
const ACTION_RIGHT := "move_right"
const ACTION_UP := "move_up"

const ANIMATION_IDLE_DOWN := "idle_down"
const ANIMATION_IDLE_LEFT := "idle_left"
const ANIMATION_IDLE_UP := "idle_up"

const ANIMATION_WALKING_DOWN := "walking_down"
const ANIMATION_WALKING_LEFT := "walking_left"
const ANIMATION_WALKING_UP := "walking_up"

export var m_player_speed = 1000.0
onready var bubble = $EmoteBubble
onready var animation = $AnimatedSprite

var m_direction := Vector2(0, 1)

func _physics_process(delta) -> void:
	var x = Input.get_action_strength(ACTION_RIGHT) - Input.get_action_strength(ACTION_LEFT)
	var y = Input.get_action_strength(ACTION_DOWN) - Input.get_action_strength(ACTION_UP)
	if x != 0 or y != 0:
		var angle = get_angle_to(position + Vector2(x,y).normalized())
		m_direction = IsometricVector.angle_to_isometric_vector(angle)
		move_and_slide(m_direction * m_player_speed, Vector2.UP)
		change_walking_animation()
	else:
		change_idle_animation()

func change_idle_animation():
	if m_direction.y < -0.01:
		if m_direction.x < 0.01 and m_direction.x > -0.01:
			animation.play(ANIMATION_IDLE_UP)
			animation.flip_h = false
	elif m_direction.y > 0.01:
		if m_direction.x < 0.01 and m_direction.x > -0.01:
			animation.play(ANIMATION_IDLE_DOWN)
			animation.flip_h = false
	if m_direction.x > 0.01:
		animation.play(ANIMATION_IDLE_LEFT)
		animation.flip_h = true
	elif m_direction.x < -0.01:
		animation.play(ANIMATION_IDLE_LEFT)
		animation.flip_h = false

func change_walking_animation():
	if m_direction.y < -0.01:
		if m_direction.x < 0.01 and m_direction.x > -0.01:
			animation.play(ANIMATION_WALKING_UP)
			animation.flip_h = false
	elif m_direction.y > 0.01:
		if m_direction.x < 0.01 and m_direction.x > -0.01:
			animation.play(ANIMATION_WALKING_DOWN)
			animation.flip_h = false
	if m_direction.x > 0.01:
		animation.play(ANIMATION_WALKING_LEFT)
		animation.flip_h = true
	elif m_direction.x < -0.01:
		animation.play(ANIMATION_WALKING_LEFT)
		animation.flip_h = false
