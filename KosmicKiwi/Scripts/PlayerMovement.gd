extends KinematicBody2D

const ACTION_DOWN := "move_down"
const ACTION_LEFT := "move_left"
const ACTION_RIGHT := "move_right"
const ACTION_UP := "move_up"

const ANIMATION_DOWN := "down"
const ANIMATION_DOWN_LEFT := "down_left"
const ANIMATION_LEFT := "left"
const ANIMATION_UP := "up"
const ANIMATION_UP_LEFT := "up_left"

export var m_speed : float
var m_direction := Vector2(0, 1)

onready var animation = $AnimatedSprite

func _ready():
	$BubbleTime.connect("timeout", self, "hide_bubble")
	PlayerManager.set_player(self)

func _physics_process(delta) -> void:
	var x = Input.get_action_strength(ACTION_RIGHT) - Input.get_action_strength(ACTION_LEFT)
	var y = Input.get_action_strength(ACTION_DOWN) - Input.get_action_strength(ACTION_UP)
	if x != 0 or y != 0:
		var angle = get_angle_to(position + Vector2(x,y).normalized())
		m_direction = IsometricVector.angle_to_isometric_vector(angle)
		move_and_slide(m_direction * m_speed, Vector2.UP)
		change_animation()

func change_animation():
	if m_direction.y < -0.01:
		if m_direction.x > 0.01:
			animation.play(ANIMATION_UP_LEFT)
			animation.flip_h = true
		elif m_direction.x < -0.01:
			animation.play(ANIMATION_UP_LEFT)
			animation.flip_h = false
		else:
			animation.play(ANIMATION_UP)
			animation.flip_h = false
	elif m_direction.y > 0.01:
		if m_direction.x > 0.01:
			animation.play(ANIMATION_DOWN_LEFT)
			animation.flip_h = true
		elif m_direction.x < -0.01:
			animation.play(ANIMATION_DOWN_LEFT)
			animation.flip_h = false
		else:
			animation.play(ANIMATION_DOWN)
			animation.flip_h = false
	elif m_direction.x > 0.01:
		animation.play(ANIMATION_LEFT)
		animation.flip_h = true
	elif m_direction.x < -0.01:
		animation.play(ANIMATION_LEFT)
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
	
func show_bubble(item_name: String, texture) -> void:
	$Bubble.visible = true;
	$Bubble/Texture.texture = texture
	$BubbleTime.start()
		
func hide_bubble() -> void:
	$Bubble.visible = false
