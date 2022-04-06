extends Node2D

const DEFAULT_ANIMATION = "default"
const PICKUP_ANIMATION = "collect"

onready var m_animator = $AnimatedSprite

func _on_ResourceDeposit_interacted():
	pick_up()

func _on_ResourceDeposit_timeout():
	reset()

func pick_up():
	m_animator.play(PICKUP_ANIMATION)

func reset():
	m_animator.play(DEFAULT_ANIMATION)
