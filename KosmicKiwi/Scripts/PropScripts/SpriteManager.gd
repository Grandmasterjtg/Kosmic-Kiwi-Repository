extends Node2D

const DEFAULT_ANIM = "default_"

var m_planet : String
onready var m_animator = $AnimatedSprite

func _ready():
	m_planet = PlanetManager.get_active_planet().get_planet_name()
	m_animator.play(DEFAULT_ANIM + m_planet)
