extends Node2D

const DEFAULT_ANIM = "default_"
const PICKUP_ANIM = "collect_"

var m_planet : String
onready var m_animator = $AnimatedSprite

func _ready():
	$ResourceDeposit.connect("interacted", self, "pickup")
	$ResourceDeposit.connect("timeout", self, "reset")
	$ResourceDeposit.connect("destroy", self, "queue_free")
	m_planet = PlanetManager.get_active_planet().get_planet_name()

func _on_ResourceDeposit_interacted():
	pick_up()

func _on_ResourceDeposit_timeout():
	reset()

func pick_up():
	m_animator.play(PICKUP_ANIM + m_planet)

func reset():
	m_animator.play(DEFAULT_ANIM + m_planet)
