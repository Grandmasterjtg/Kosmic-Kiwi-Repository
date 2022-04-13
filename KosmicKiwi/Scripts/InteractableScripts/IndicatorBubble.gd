extends AnimatedSprite

onready var m_sprite = $Sprite
onready var m_timer = $Timer

var m_open := false

func _ready() -> void:
	m_timer.connect("timeout",self,"_on_Timer_timeout")
	self.visible = false
	m_sprite.visible = false

func open_bubble():
	m_open = true
	self.visible = true
	animation = "open"
	play()
	m_timer.start()

func close_bubble():
	m_open = false
	m_sprite.visible = false
	animation = "close"
	play()
	m_timer.start()

func set_texture(texture: Texture):
	m_sprite.texture = texture

func _on_Timer_timeout():
	if m_open:
		m_sprite.visible = true
	else:
		m_sprite.visible = false
		self.visible = false
