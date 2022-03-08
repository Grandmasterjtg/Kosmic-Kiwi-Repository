extends KinematicBody2D

const ACTION_DOWN := "move_down"
const ACTION_HOTBAR_1 := "hotbar_1"
const ACTION_HOTBAR_2 := "hotbar_2"
const ACTION_HOTBAR_3 := "hotbar_3"
const ACTION_HOTBAR_4 := "hotbar_4"
const ACTION_LEFT := "move_left"
const ACTION_RIGHT := "move_right"
const ACTION_UP := "move_up"

export var speed := 100.0
var direction := "S"

func _physics_process(delta):
	var horizontal_movement = speed * delta * (Input.get_action_strength(ACTION_RIGHT) - Input.get_action_strength(ACTION_LEFT))
	var vertical_movement = speed * delta * (Input.get_action_strength(ACTION_DOWN) - Input.get_action_strength(ACTION_UP))
	move_local_x(horizontal_movement)
	move_local_y(vertical_movement)
	if horizontal_movement == 0 and vertical_movement < 0:
		direction = "N"
		get_child(0).rotation_degrees = 180
	elif horizontal_movement > 0 and vertical_movement < 0:
		direction = "NE"
		get_child(0).rotation_degrees = 225
	elif horizontal_movement > 0 and vertical_movement == 0:
		direction = "E"
		get_child(0).rotation_degrees = 270
	elif horizontal_movement > 0 and vertical_movement > 0:
		direction = "SE"
		get_child(0).rotation_degrees = 315
	elif horizontal_movement == 0 and vertical_movement > 0:
		direction = "S"
		get_child(0).rotation_degrees = 0
	elif horizontal_movement < 0 and vertical_movement > 0:
		direction = "SW"
		get_child(0).rotation_degrees = 45
	elif horizontal_movement < 0 and vertical_movement == 0:
		direction = "W"
		get_child(0).rotation_degrees = 90
	elif horizontal_movement < 0 and vertical_movement < 0:
		direction = "NW"
		get_child(0).rotation_degrees = 135

func _input(event):
	if event.is_action_pressed(ACTION_HOTBAR_1):
		instantiate_image(0.1)
	elif event.is_action_pressed(ACTION_HOTBAR_2):
		instantiate_image(0.25)
	elif event.is_action_pressed(ACTION_HOTBAR_3):
		instantiate_image(0.5)
	elif event.is_action_pressed(ACTION_HOTBAR_4):
		instantiate_image(1)

func instantiate_image(scale):
	var sprite = Sprite.new()
	sprite.texture = self.get_child(0).texture
	sprite.position = self.position
	sprite.scale *= scale
	sprite.z_index = 0
	var size_x = sprite.scale.x * sprite.texture.get_size().x / 2 + self.get_child(0).texture.get_size().x / 2
	var size_y = sprite.scale.y * sprite.texture.get_size().y / 2 + self.get_child(0).texture.get_size().y / 2
	if direction == "N":
		sprite.position.y -= size_y + 10
	if direction == "NE":
		sprite.position.x += size_x
		sprite.position.y -= size_y
	if direction == "E":
		sprite.position.x += size_x + 10
	if direction == "SE":
		sprite.position.x += size_x
		sprite.position.y += size_y
	if direction == "S":
		sprite.position.y += size_y + 10
	if direction == "SW":
		sprite.position.x -= size_x
		sprite.position.y += size_y
	if direction == "W":
		sprite.position.x -= size_x + 10
	if direction == "NW":
		sprite.position.x -= size_x
		sprite.position.y -= size_y
	get_parent().add_child(sprite)
