extends KinematicBody2D

const ACTION_DOWN := "move_down"
const ACTION_HOTBAR_1 := "hotbar_1"
const ACTION_HOTBAR_2 := "hotbar_2"
const ACTION_HOTBAR_3 := "hotbar_3"
const ACTION_HOTBAR_4 := "hotbar_4"
const ACTION_LEFT := "move_left"
const ACTION_RIGHT := "move_right"
const ACTION_UP := "move_up"

const ANIMATION_IDLE_DOWN := "idle_down"
const ANIMATION_IDLE_DOWN_LEFT := "idle_down_left"
const ANIMATION_IDLE_LEFT := "idle_left"
const ANIMATION_IDLE_UP := "idle_up"
const ANIMATION_IDLE_UP_LEFT := "idle_up_left"

const ANIMATION_WALKING_DOWN := "walking_down"
const ANIMATION_WALKING_DOWN_LEFT := "walking_down_left"
const ANIMATION_WALKING_LEFT := "walking_left"
const ANIMATION_WALKING_UP := "walking_up"
const ANIMATION_WALKING_UP_LEFT := "walking_up_left"

export var m_speed : float
var m_direction := Vector2(0, 1)

onready var animation = $AnimatedSprite

func _physics_process(delta) -> void:
	var x = Input.get_action_strength(ACTION_RIGHT) - Input.get_action_strength(ACTION_LEFT)
	var y = Input.get_action_strength(ACTION_DOWN) - Input.get_action_strength(ACTION_UP)
	if x != 0 or y != 0:
		var angle = get_angle_to(position + Vector2(x,y).normalized())
		m_direction = IsometricVector.angle_to_isometric_vector(angle)
		move_and_slide(m_direction * m_speed, Vector2.UP)
		change_walking_animation()
	else:
		change_idle_animation()

func change_idle_animation():
	if m_direction.y < -0.01:
		if m_direction.x > 0.01:
			animation.play(ANIMATION_IDLE_UP_LEFT)
			animation.flip_h = true
		elif m_direction.x < -0.01:
			animation.play(ANIMATION_IDLE_UP_LEFT)
			animation.flip_h = false
		else:
			animation.play(ANIMATION_IDLE_UP)
			animation.flip_h = false
	elif m_direction.y > 0.01:
		if m_direction.x > 0.01:
			animation.play(ANIMATION_IDLE_DOWN_LEFT)
			animation.flip_h = true
		elif m_direction.x < -0.01:
			animation.play(ANIMATION_IDLE_DOWN_LEFT)
			animation.flip_h = false
		else:
			animation.play(ANIMATION_IDLE_DOWN)
			animation.flip_h = false
	elif m_direction.x > 0.01:
		animation.play(ANIMATION_IDLE_LEFT)
		animation.flip_h = true
	elif m_direction.x < -0.01:
		animation.play(ANIMATION_IDLE_LEFT)
		animation.flip_h = false

func change_walking_animation():
	if m_direction.y < -0.01:
		if m_direction.x > 0.01:
			animation.play(ANIMATION_WALKING_UP_LEFT)
			animation.flip_h = true
		elif m_direction.x < -0.01:
			animation.play(ANIMATION_WALKING_UP_LEFT)
			animation.flip_h = false
		else:
			animation.play(ANIMATION_WALKING_UP)
			animation.flip_h = false
	elif m_direction.y > 0.01:
		if m_direction.x > 0.01:
			animation.play(ANIMATION_WALKING_DOWN_LEFT)
			animation.flip_h = true
		elif m_direction.x < -0.01:
			animation.play(ANIMATION_WALKING_DOWN_LEFT)
			animation.flip_h = false
		else:
			animation.play(ANIMATION_WALKING_DOWN)
			animation.flip_h = false
	elif m_direction.x > 0.01:
		animation.play(ANIMATION_WALKING_LEFT)
		animation.flip_h = true
	elif m_direction.x < -0.01:
		animation.play(ANIMATION_WALKING_LEFT)
		animation.flip_h = false

func instantiate_image(scale) -> void:
	var sprite = Sprite.new()
	sprite.texture = get_child(0).texture
	sprite.position = position
	sprite.scale *= scale
	sprite.z_index = 0
	var size_x = sprite.scale.x * sprite.texture.get_size().x / 2 + get_child(0).texture.get_size().x / 2 + 10
	var size_y = sprite.scale.y * sprite.texture.get_size().y / 2 + get_child(0).texture.get_size().y / 2 + 10
	sprite.position.x += m_direction.x * size_x
	sprite.position.y += m_direction.y * size_y
	get_parent().add_child(sprite)
