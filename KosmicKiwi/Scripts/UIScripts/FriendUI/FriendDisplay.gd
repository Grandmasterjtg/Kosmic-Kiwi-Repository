extends Control

onready var m_friend_texture = $Panel/AspectRatioContainer/TextureRect
onready var m_texture_progress = $TextureProgress
onready var m_cooldown_timer = $CooldownTimer

var m_on_cooldown := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	m_cooldown_timer.connect("timeout",self,"end_cooldown")

func _physics_process(delta: float) -> void:
	if m_on_cooldown:
		var cooldown_value = m_cooldown_timer.time_left * (100/m_cooldown_timer.wait_time)
		set_texture_progress(cooldown_value)

func set_texture(texture: Texture):
	m_friend_texture.texture = texture

func get_texture() -> Texture:
	return m_friend_texture

func set_texture_progress(new_value: int):
	m_texture_progress.value = new_value

func start_cooldown():
	m_on_cooldown = true
	m_cooldown_timer.start()

func end_cooldown():
	m_on_cooldown = false

func on_cooldown() -> bool:
	return m_on_cooldown
