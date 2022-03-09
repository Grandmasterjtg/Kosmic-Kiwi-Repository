extends KinematicBody2D

const ACTION_DOWN := "move_down"
const ACTION_HOTBAR_1 := "hotbar_1"
const ACTION_HOTBAR_2 := "hotbar_2"
const ACTION_HOTBAR_3 := "hotbar_3"
const ACTION_HOTBAR_4 := "hotbar_4"
const ACTION_LEFT := "move_left"
const ACTION_RIGHT := "move_right"
const ACTION_UP := "move_up"

export var m_speed := 10000.0
var m_direction := Vector2(0, 1)

func _physics_process(delta) -> void:
	var horizontal_movement = m_speed * delta * \
		(Input.get_action_strength(ACTION_RIGHT) - Input.get_action_strength(ACTION_LEFT))
	var vertical_movement = m_speed * delta * \
		(Input.get_action_strength(ACTION_DOWN) - Input.get_action_strength(ACTION_UP))
	move_and_slide(Vector2(horizontal_movement, vertical_movement), Vector2.UP)
	if horizontal_movement != 0 or vertical_movement != 0:
		m_direction = Vector2(horizontal_movement, vertical_movement).normalized()
	get_child(0).rotation = get_angle_to(position + m_direction) - PI / 2

func _input(event) -> void:
	if event.is_action_pressed(ACTION_HOTBAR_1):
		instantiate_image(0.1)
	elif event.is_action_pressed(ACTION_HOTBAR_2):
		instantiate_image(0.25)
	elif event.is_action_pressed(ACTION_HOTBAR_3):
		instantiate_image(0.5)
	elif event.is_action_pressed(ACTION_HOTBAR_4):
		instantiate_image(1)

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
