extends Node2D

const DESERT = "Desert"
const FOREST = "Forest"
const JUNGLE = "Jungle"
const WET = "Wet"

var m_planet : String
onready var m_animator = $AnimatedSprite
onready var m_d_collider = $DesertCollider
onready var m_f_collider = $ForestCollider
onready var m_j_collider = $JungleCollider
onready var m_w_collider = $WetCollider

func _ready():
	m_planet = PlanetManager.get_active_planet().get_planet_name()
	m_animator.play(m_planet)
	
	if m_planet == DESERT:
		m_d_collider.disabled = false
	if m_planet == FOREST:
		m_f_collider.disabled = false
	if m_planet == JUNGLE:
		m_j_collider.disabled = false
	if m_planet == WET:
		m_w_collider.disabled = false
