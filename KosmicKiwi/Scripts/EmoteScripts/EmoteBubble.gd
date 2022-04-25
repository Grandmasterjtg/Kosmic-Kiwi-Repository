extends AnimatedSprite

onready var m_texture_container = $PanelContainer
onready var m_texture = $PanelContainer/TextureRect
onready var m_visible_timer = $VisibleTimer
onready var m_open_timer = $OpenTimer

var m_open := false

func _ready() -> void:
	m_visible_timer.connect("timeout",self,"_on_VisibleTimer_timeout")
	m_open_timer.connect("timeout",self,"close_bubble")
	self.visible = false
	m_texture_container.visible = false

func open_bubble() -> void:
	m_open = true
	m_texture_container.visible = false
	self.visible = true
	animation = "open"
	play()
	m_visible_timer.start()
	m_open_timer.start()

func close_bubble():
	m_open = false
	m_texture_container.visible = false
	animation = "close"
	play()
	m_visible_timer.start()

func set_texture(texture: Texture):
	m_texture.texture = texture

func open_bubble_with_texture(texture: Texture):
	set_texture(texture)
	open_bubble()

func _on_VisibleTimer_timeout():
	if m_open:
		m_texture_container.visible = true
	else:
		m_texture_container.visible = false
		self.visible = false
